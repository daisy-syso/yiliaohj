module Frontend
  class NursingRoomsController < FrontendController
    def index
      @proviences = Provience.includes(:cities)

      query = {}

      # 分类
      if params[:category_name]
        query[:categories] = params[:category_name]
      end

      # 城市
      city = params[:city] || $redis_position.get("#{request.remote_ip}_city") || '上海市'
      query[:city] = City.where(name: city).first

      @nursing_rooms = NursingRoom.includes(:comments).includes(:commodities).where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @nursing_rooms = @nursing_rooms.geo_near([longitude, latitude]).spherical.max_distance(1000).to_a
        when 'new'
          # 最近发布
          @nursing_rooms = @nursing_rooms.desc(:created_at)
        when 'star'
          # 评价最好
          @nursing_rooms = @nursing_rooms.desc(:star)
        when 'click_count'
          # 人气最高
          @nursing_rooms = @nursing_rooms.desc(:click_count)
        end
      end

      if params[:sort_type] == 'neighbour'
        @nursing_rooms = Kaminari.paginate_array(@nursing_rooms).page(params[:page]).per(params[:per])
      else
        @nursing_rooms = @nursing_rooms.page(params[:page]).per(params[:per])
      end

    end

    def show
      @nursing_room = NursingRoom.includes(:comments).find(params[:id])

      @nursing_room.visit!

      @comments = @nursing_room.comments.desc(:created_at).first
    end
  end
end

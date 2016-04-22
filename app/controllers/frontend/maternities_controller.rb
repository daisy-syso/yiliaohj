module Frontend
  class MaternitiesController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      # @maternities = Maternity.all.page(params[:page]).per(params[:per])

      @proviences = Provience.includes(:cities)

      query = {}

      # 分类
      query[:categories] = params[:category_name] if params[:category_name]

      # 城市
      city = params[:city] || $redis_position.get("#{request.remote_ip}_city") || '上海市'
      query[:city] = City.where(name: city).first

      @maternities = Maternity.includes(:comments).includes(:commodities).where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @maternities = @maternities.geo_near([longitude, latitude]).spherical.max_distance(1000).to_a
        when 'new'
          # 最近发布
          @maternities = @maternities.desc(:created_at)
        when 'star'
          # 评价最好
          @maternities = @maternities.desc(:star)
        when 'click_count'
          # 人气最高
          @maternities = @maternities.desc(:click_count)
        end
      end

      if params[:sort_type] == 'neighbour'
        @maternities = Kaminari.paginate_array(@maternities).page(params[:page]).per(params[:per])
      else
        @maternities = @maternities.page(params[:page]).per(params[:per])
      end
    end

    def show
      @maternity = Maternity.find(params[:id])

      @maternity.visit!

      @comment = @maternity.comments.desc(:created_at).first
    end
  end
end

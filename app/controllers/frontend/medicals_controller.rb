module Frontend
  class MedicalsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      @proviences = Provience.includes(:cities)

      query = {}

      # 城市
      city = params[:city] || $redis_position.get("#{request.remote_ip}_city") || '上海市'
      query[:city] = City.where(name: city).first

      if params[:county].present?
        query[:county] = County.where(name: params[:county]).first
      end

      @medicals = Medical.includes(:comments).includes(:commodities).where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @medicals = @medicals.geo_near([longitude, latitude]).spherical.to_a
        when 'new'
          # 最近发布
          @medicals = @medicals.desc(:created_at)
        when 'star'
          # 评价最好
          @medicals = @medicals.desc(:star)
        when 'click_count'
          # 人气最高
          @medicals = @medicals.desc(:click_count)
        else
          # 最近发布
          @medicals = @medicals.desc(:created_at)
        end
      end

      if params[:sort_type] == 'neighbour'
        @medicals = Kaminari.paginate_array(@medicals).page(params[:page]).per(params[:per])
      else
        @medicals = @medicals.page(params[:page]).per(params[:per])
      end
    end

    def show
      @medical = Medical.find(params[:id])

      @medical.visit!

      @comment = @medical.comments.desc(:created_at).first
    end
  end
end

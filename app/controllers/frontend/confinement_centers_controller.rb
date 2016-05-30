module Frontend
  class ConfinementCentersController < FrontendController
    def index
      @proviences = Provience.includes(:cities)

      query = {}
      query[:categories] = params[:category_name] if params[:category_name]

      if params[:county].present?
        query[:county] = County.where(name: params[:county]).first
      end

      # 城市
      city = params[:city] || $redis_position.get("#{request.remote_ip}_city") || '上海市'
      query[:city] = City.where(name: city).first

      @confinement_centers = ConfinementCenter.includes(:comments).includes(:commodities).where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @confinement_centers = @confinement_centers.geo_near([longitude, latitude]).spherical.to_a
        when 'new'
          # 最近发布
          @confinement_centers = @confinement_centers.desc(:created_at)
        when 'star'
          # 评价最好
          @confinement_centers = @confinement_centers.desc(:star)
        when 'click_count'
          # 人气最高
          @confinement_centers = @confinement_centers.desc(:click_count)
        else
          # 最近发布
          @confinement_centers = @confinement_centers.desc(:created_at)
        end
      end

      if params[:sort_type] == 'neighbour'
        @confinement_centers = Kaminari.paginate_array(@confinement_centers).page(params[:page]).per(params[:per])
      else
        @confinement_centers = @confinement_centers.page(params[:page]).per(params[:per])
      end
    end

    def show
      @confinement_center = ConfinementCenter.find(params[:id])

      @comment = @confinement_center.comments.desc(:created_at).first
    end
  end
end

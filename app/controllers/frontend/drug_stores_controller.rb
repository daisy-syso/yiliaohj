module Frontend
  class DrugStoresController < FrontendController
    def index
      @proviences = Provience.includes(:cities)

      query = {}

      # 城市
      city = params[:city] || $redis_position.get("#{request.remote_ip}_city") || '上海市'
      query[:city] = City.where(name: city).first
      
      @drug_stores = DrugStore.where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @drug_stores = @drug_stores.geo_near([longitude, latitude]).spherical.to_a
        when 'new'
          # 最近发布
          @drug_stores = @drug_stores.desc(:created_at)
        when 'star'
          # 评价最好
          @drug_stores = @drug_stores.desc(:star)
        when 'click_count'
          # 人气最高
          @drug_stores = @drug_stores.desc(:click_count)
        else
          # 最近发布
          @drug_stores = @drug_stores.desc(:created_at)
        end
      end

      if params[:sort_type] == 'neighbour'
        @drug_stores = Kaminari.paginate_array(@drug_stores).page(params[:page]).per(params[:per])
      else
        @drug_stores = @drug_stores.page(params[:page]).per(params[:per])
      end

    end

    def show
      @drug_store = DrugStore.find(params[:id])

      @comment = @drug_store.comments.desc(:created_at).first
    end
  end
end
module Frontend
  class MainController < FrontendController
    def index
      @banners = Banner.all

      @categories = Category.all.asc(:order)
      @categories = [@categories.limit(8), @categories.offset(8).limit(8), @categories.offset(16).limit(8)]

      @advertisements = Advertisement.desc(:created_at).limit(3)

      @health_information = HealthInformation.desc(:created_at).limit(3)

      @import_drugs = ImportDrug.desc(:created_at).limit(3)

      @hot_actions = HotAction.all.desc(:created_at).limit(6)

      @recommendations = Recommendation.all.desc(:created_at).page(params[:page]).per(params[:per])
    end

    def upload_position
      $redis_position.set(request.remote_ip, "#{params[:lat]},#{params[:lon]}")
      $redis_position.set("#{request.remote_ip}_city", params[:city])

      render json: { mes: 'ok' }
    end
  end
end

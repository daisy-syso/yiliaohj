module Frontend
  class MainController < FrontendController
    def index
      @banners = Banner.all

      @categories = Category.all.asc(:order)
      @categories = [@categories.limit(8), @categories.offset(8).limit(8)]

      @advertisements = Advertisement.all

      @health_information = HealthInformation.all

      @import_drugs = ImportDrug.all

      @hot_actions = HotAction.all.desc(:created_at).limit(6)

      @recommendations = Recommendation.all.desc(:created_at).page(params[:page]).per(params[:per])
    end

    def upload_position
      $redis_position.set(request.remote_ip, "#{params[:lat]},#{params[:lon]}")

      render json: {mes: 'ok'}
    end
  end
end

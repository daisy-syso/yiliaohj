module Frontend
  class DiseasesController < FrontendController

    def index
      @diseases =  Disease.all.page(params[:page]).per(params[:per])
    end
  end
end

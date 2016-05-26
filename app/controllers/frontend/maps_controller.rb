module Frontend
  class MapsController < FrontendController
    def index
      @lng = params[:location].split(',')[1]
      @lat = params[:location].split(',')[0]
    end
  end
end

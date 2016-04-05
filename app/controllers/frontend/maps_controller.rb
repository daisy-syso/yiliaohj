module Frontend
  class MapsController < FrontendController
    layout false
    def index
      @lng = params[:location].split(',')[1]
      @lat = params[:location].split(',')[0]
    end
  end
end

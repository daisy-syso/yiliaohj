module Frontend
  class HospitalsController < FrontendController
    def index
      @hospitals = Hospital.all.desc(:created_at).page(params[:page]).per(params[:per])
    end

    def show
      @hospital = Hospital.find(params[:id])
    end
  end
end

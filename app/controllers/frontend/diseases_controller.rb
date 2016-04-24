module Frontend
  class DiseasesController < FrontendController
    def index
      query = {}
      if params[:department_id]
        set_department
        @diseases = @department.diseases.page(params[:page]).per(params[:per])
      else
        @diseases = Disease.desc(:created_at).page(params[:page]).per(params[:per])
      end
    end

    def show
      @disease = Disease.find(params[:id])
    end

    private

    def set_department
      @department = Department.find(params[:department_id])
    end
  end
end

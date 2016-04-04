module Frontend
  class ExaminationsController
    def index

    end

    def show
      @examination = Examination.includes(:comments).includes(:examination_details).includes(:examination_category)
                      .find(params[:id])
      @comments = @examination.comments
      @examination_details = @examination.examination_details
      @examination_category = @examination.examination_category
    end
  end
end
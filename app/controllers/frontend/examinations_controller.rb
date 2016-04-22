module Frontend
  class ExaminationsController < FrontendController
    def index
      @examinations = Examination.all.page(params[:page]).per(params[:per])
    end

    def show
      @examination = Examination.includes(:comments).find(params[:id])

      @comment = @examination.comments.desc(:created_at).first

      # @comments = @examination.comments
      # @examination_details = @examination.examination_details
      # @examination_category = @examination.examination_category
    end
  end
end

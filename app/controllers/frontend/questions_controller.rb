module Frontend
  class QuestionsController < FrontendController
    before_action :auth_check, only: [:new, :create, :show]
    before_action :set_question, only: [:show]

    def show
    end

    def new
      @question = @current_user.questions.new
    end

    def create
      @question = @current_user.questions.new question_params
      redirect_to frontend_person_customs_path if @question.save
    end

    private

    def question_params
      params.require(:question).permit(:telephone, :email, :content)
    end

    def set_question
      @question = @current_user.questions.find(params[:id])
    end
  end
end

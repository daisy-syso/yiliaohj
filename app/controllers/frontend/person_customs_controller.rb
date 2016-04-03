module Frontend
  class PersonCustomsController < FrontendController
    before_action :auth_check, only: [:index]

    def index
      @information_categories = InformationCategory.where(name: '疾病').first.children

      @information_category_ids = @current_user.subscriptions.map(&:information_category_ids).flatten

      @questions = @current_user.questions
    end

  end
end

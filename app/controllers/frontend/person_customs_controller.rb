module Frontend
  class PersonCustomsController < FrontendController
    before_action :auth_check, only: [:index]

    def index
      @information_categories = InformationCategory.where(name: '疾病').first.children

      @information_category_ids = @current_user.subscriptions.map(&:information_category_ids).flatten

      # @information_category_ids = @current_user.subscriptions.map(&:information_category_ids).flatten

      @information_categories = InformationCategory.includes(:information).where(:id.in => @information_category_ids)

      @questions = @current_user.questions.desc(:updated_at)
    end
  end
end

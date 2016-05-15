module Frontend
  class PersonCustomsController < FrontendController
    before_action :auth_check, only: [:index]

    def index
      # 大分类
      @subscription_categories = SubscriptionCategory.where(parent_id: nil).includes(:children)

      # 已经关注的分类
      @subscription_category_ids = @current_user.subscriptions.map(&:subscription_category_ids).flatten

      # @information_categories = SubscriptionCategory.includes(:information).where(:id.in => @information_category_ids)

      # 问题
      @questions = @current_user.questions.desc(:updated_at)

      @information_categories = []
    end
  end
end

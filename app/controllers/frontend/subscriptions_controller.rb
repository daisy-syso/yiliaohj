module Frontend
  class SubscriptionsController < FrontendController
    before_action :auth_check, only: [:index, :create, :destroy]

    def index
      @subscription_category_ids = @current_user.subscriptions.map(&:subscription_category_ids).flatten

      @subscription_categories = SubscriptionCategory.includes(:information).where(:id.in => @subscription_category_ids)
    end

    def create
      @subscription_category_ids = @current_user.subscriptions.map(&:subscription_category_ids).flatten

      category_name_ids = params[:category_name_ids] || []

      all_category_name_ids = params[:all_category_name_ids] || []

      delete_category_name_ids = all_category_name_ids - category_name_ids

      category_name_ids.each do |category_name_id|
        ic = SubscriptionCategory.where(id: category_name_id).first

        next unless ic.present? && !@subscription_category_ids.include?(ic.id)
        subscription = @current_user.subscriptions.new
        subscription.subscription_categories << ic
        subscription.save
      end

      SubscriptionCategory.where(:id.in => delete_category_name_ids).each do |ic|
        if ic.present? && @subscription_category_ids.include?(ic.id)
          subscription_category = @current_user.subscriptions.where(subscription_category_ids: ic.id).first
          subscription_category.destroy
        end
      end

      render json: { message: 'ok' }
    end
  end
end

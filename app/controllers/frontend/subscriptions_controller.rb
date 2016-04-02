module Frontend
  class SubscriptionsController < FrontendController
    before_action :auth_check, only: [:index, :create, :destroy]

    def index
      # @subscriptions = @current_user.subscriptions.map(&:information_category_ids).flatten
      subscription_ids = Subscription.all.map(&:information_category_ids).flatten

      @information_categories = InformationCategory.where(:id.in => Subscription.all.map(&:information_category_ids).flatten)
    end

    def create
      subscription = @current_user.subscriptions.new
      subscription.information_categories << @information_category
      subscription.save

      # subscription = @current_user.subscriptions.find_or_initialize_by(information_category_id: params[:information_category_id])
      # if subscription.new_record?
      #   # name = InformationCategory.find(params[:information_category_id]).name

      #   subscription.save
      #   message = "#{name} 关注成功"
      # end

      # flash[:alert] = message

      # redirect_to frontend_subscriptions_path
    end

    def destroy

    end

    private

    def set_information_category
      @information_category = InformationCategory.find(params[:id])
    end

  end
end

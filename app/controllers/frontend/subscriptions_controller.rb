module Frontend
  class SubscriptionsController < FrontendController
    before_action :auth_check, only: [:index, :create, :destroy]

    def index
      @information_category_ids = @current_user.subscriptions.map(&:information_category_ids).flatten

      @information_categories = InformationCategory.includes(:information).where(:id.in => @information_category_ids)
    end

    def create
      @information_category_ids = @current_user.subscriptions.map(&:information_category_ids).flatten

      category_name_ids = params[:category_name_ids] || []

      all_category_name_ids = params[:all_category_name_ids] || []

      delete_category_name_ids = all_category_name_ids - category_name_ids

      category_name_ids.each do |category_name_id|
        ic = InformationCategory.where(id: category_name_id).first
        
        if ic.present? && !@information_category_ids.include?(ic.id)
          subscription = @current_user.subscriptions.new
          subscription.information_categories << ic
          subscription.save
        end
      end

      delete_category_name_ids.each do |category_name_id|
        ic = InformationCategory.where(id: category_name_id).first

        if ic.present? && @information_category_ids.include?(ic.id)
          information_category = @current_user.subscriptions.where(information_category_ids: ic.id).first
          information_category.destroy
        end
      end

      render json: {message: 'ok'}
    end
    
  end
end

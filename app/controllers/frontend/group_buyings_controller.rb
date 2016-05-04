module Frontend
  class GroupBuyingsController < FrontendController
    before_action :set_hospital_category, only: [:index]

    def index
      @group_buyings = @hospital_category.group_buyings
    end

    private

    def set_hospital_category
      @hospital_category = HospitalCategory.find(params[:hospital_category_id])
    end
  end
end

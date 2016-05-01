module Frontend
  class GroupBuyingsController < FrontendController
    def index
      @group_buyings = GroupBuying.all
    end
  end
end

module Frontend
  class StrategyCategoriesController < FrontendController
    def index
      @strategy_categories = StrategyCategory.where(parent_id: nil)
    end

    def sub_strategy_categories
      @sub_strategy_categories = StrategyCategory.where(parent_id: params[:id])
    end
  end
end
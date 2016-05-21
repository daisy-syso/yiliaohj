module Frontend
  class StrategyCategoriesController < FrontendController
    def index
      @strategy_categories = StrategyCategory.where(parent_id: nil)
    end

    def sub_strategy_categories
      # 573eafd55b2cd71e1c185084
      @sub_strategy_categories = StrategyCategory.where(strategy_category_id: params[:id])
    end
  end
end
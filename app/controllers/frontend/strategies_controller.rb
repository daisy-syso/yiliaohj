module Frontend
  class StrategiesController < FrontendController
    before_action :get_strategy_category, only: [:index]
    
    def index
      @strategies = @strategy_category.strategies.desc(:created_at).page(params[:page]).per(params[:per])
    end

    def show
      @strategy = Strategy.find(params[:id])
    end

    private

    def get_strategy_category
      @strategy_category = StrategyCategory.find(params[:strategy_category_id])
    end
  end
end

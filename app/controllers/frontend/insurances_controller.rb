module Frontend
  class InsurancesController < FrontendController
    def index
      @proviences = Provience.includes(:cities)

      query = {}
      @insurances = Insurance.includes(:comments).includes(:commodities).where(query)

      if params[:sort_type].present?
        @insurances = case params[:sort_type]
                      when 'new'
                        # 最近发布
                        @insurances.desc(:created_at)
                      when 'star'
                        # 评价最好
                        @insurances.desc(:star)
                      when 'click_count'
                        # 人气最高
                        @insurances.desc(:click_count)
                      else
                        # 最近发布
                        @insurances.desc(:created_at)
                      end
      end

      @insurances = @insurances.page(params[:page]).per(params[:per])
    end

    def show
      # @insurance = Insurance.includes(:comments).includes(:commodities).includes(:insurance_company)
      # .find(params[:id])
      # @comments = @insurance.comments
      # @commodities = @insurance.commodities
      # @insurance_company = @insurance.insurance_company

      @insurance = Insurance.includes(:comments).find(params[:id])

      @insurance.visit!

      @comment = @insurance.comments.desc(:created_at).first
    end
  end
end

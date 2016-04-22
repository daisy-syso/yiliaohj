module Frontend
  class InsurancesController < FrontendController
    def index
      @insurances = Insurance.all.page(params[:page]).per(params[:per])
    end

    def show
      # @insurance = Insurance.includes(:comments).includes(:commodities).includes(:insurance_company)
      # .find(params[:id])
      # @comments = @insurance.comments
      # @commodities = @insurance.commodities
      # @insurance_company = @insurance.insurance_company

      @insurance = Insurance.includes(:comments).find(params[:id])

      @comment = @examination.comments.desc(:created_at).first
    end
  end
end

module Frontend
  class InsurancesController
    def index

    end

    def show
      @insurance = Insurance.includes(:comments).includes(:commodities).includes(:insurance_company)
                    .find(params[:id])
      @comments = @insurance.comments
      @commodities = @insurance.commodities
      @insurance_company = @insurance.insurance_company
    end
  end
end
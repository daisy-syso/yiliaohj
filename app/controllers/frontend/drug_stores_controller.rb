module Frontend
  class DrugStoresController
    def index

    end

    def show
      @drug_store = DrugStore.find(params[:id])
    end
  end
end
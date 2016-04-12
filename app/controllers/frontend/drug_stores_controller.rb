module Frontend
  class DrugStoresController < FrontendController
    def index
      query = {}
      if params[:category_name]
        query[:categories] = params[:category_name]
      end
      @drug_stores = DrugStore.where(query).page(params[:page]).per(params[:per])
    end

    def show
      @drug_store = DrugStore.find(params[:id])

      @comment = @drug_store.comments.desc(:created_at).first
    end
  end
end
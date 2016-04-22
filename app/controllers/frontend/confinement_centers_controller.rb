module Frontend
  class ConfinementCentersController < FrontendController
    def index
      @proviences = Provience.includes(:cities)

      query = {}
      query[:categories] = params[:category_name] if params[:category_name]
      @confinement_centers = ConfinementCenter.where(query).page(params[:page]).per(params[:per])
    end

    def show
      @confinement_center = ConfinementCenter.find(params[:id])

      @comment = @confinement_center.comments.desc(:created_at).first
    end
  end
end

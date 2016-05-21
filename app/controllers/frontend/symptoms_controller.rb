module Frontend
  class SymptomsController < FrontendController
    def index
      @symptom_first_chars = Symptom.all.asc(:english).pluck(:english).collect {|c| c[0]}.uniq

    end

    def show
      @symptom = Symptom.find(params[:id])
    end
  end
end

module Frontend
  class SymptomsController < FrontendController
    def index
      @symptoms = Symptom.order(id: :asc)
    end

    def load
      @symptom = Symptom.find(params[:id])
      @symptoms = Symptom
      .order(id: :asc)
      .where(english: params[:english])
      .where(:id.gt => @symptom.id).limit(10)

      html = ''
      @symptoms.each do |symptom|
        html += %Q(<li class="symptom-item">
          <a href="symptoms/#{symptom.id}" data-id="#{symptom.id}" data-english="#{params[:english]}">#{symptom.name}</a>
      </li>)
      end
      render text: html
    end

    def show
      @symptom = Symptom.find(params[:id])
    end
  end
end

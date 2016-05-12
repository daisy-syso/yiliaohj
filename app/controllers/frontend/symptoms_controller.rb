module Frontend
  class SymptomsController < FrontendController
    def index
      @symptoms = Symptom.order(display_index: :asc)
    end

    def load
      @symptom = Symptom.find(params[:id])
      @symptoms = Symptom
      .order(display_index: :asc)
      .where(english: params[:english])
      .where(:display_index.gt => @symptom.display_index).limit(10)

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

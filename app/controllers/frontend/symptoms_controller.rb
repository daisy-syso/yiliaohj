module Frontend
  class SymptomsController < FrontendController
    def index
      @symptom_first_chars = Symptom.all.asc(:english).pluck(:english).collect {|c| c[0]}.uniq
    end

    def get_more
      char = params[:char]
      page = params[:page].to_i

      params_one = page * 10
      params_two = params_one + 9

      results = $redis_symptoms.lrange(char, params_one, params_two)

      html = ""
      results.each do |r|
        html += %Q(<li class="symptom-item"><a href="symptoms/#{r.split(',')[0]}"> #{r.split(',')[1]}</a></li>)
      end

      render text: html
    end

    def show
      @symptom = Symptom.find(params[:id])
    end
  end
end

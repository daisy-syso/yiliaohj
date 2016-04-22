module Frontend
  class SymptomsController < FrontendController
    def index
      if $redis_symptoms.hget('symptoms', 'A').blank?
        symptoms = Symptom.all
        hash = {}
        symptoms.each do |s|
          if hash.keys.include? s.english
            aa = hash[s.english]
            aa = aa + '|' + [s.id.to_s, s.name].join(',')
            hash[s.english] = aa
          else
            hash[s.english] = [[s.id.to_s, s.name].join(',')].join('|')
          end
          $redis_symptoms.hset('symptoms', s.english, hash[s.english])
        end
      end
    end

    def show
      @symptom = Symptom.find(params[:id])
    end
  end
end

module Frontend
  class SymptomsController < FrontendController
    def index
      symptoms = Symptom.all#.page(params[:page]).per(10)
      arr = {}
      symptoms.each do |s|
        if arr.keys.include? s.english
          aa = arr[s.english]
          aa << [s.id.to_s, s.name]
          arr[s.english] = aa
        else
          arr[s.english] = [[s.id.to_s, s.name]]
        end
      end

      @symptoms = arr
    end

    def show
      @symptom = Symptom.find(params[:id])
    end
  end
end
class Frontend::CitiesController < FrontendController

  def index
    @hot_cities = City.where(is_hot: true)

    city_chars = City.all.asc(:english).pluck(:english).collect {|c| c}.uniq

    @all_cities = {}
    city_chars.each do |char|
      arr = []
      City.where(english: char).asc(:english).each do |s|
        # puts s.english
        # $redis_symptoms.rpush char, "#{s.id.to_s},#{s.name}"
        arr << s.name
      end
      @all_cities[:"#{char}"] = arr
    end

    @current_city = '上海市'
  end

  def cities_search
    query = params[:query]

    cities = City.or(name: /#{query}/).or(english: /#{query}/).page(params[:page]).per(params[:per])

    render json: {data: cities.pluck(:name)}.to_json
  end
end

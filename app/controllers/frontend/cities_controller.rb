class Frontend::CitiesController < FrontendController

  def index
    @hot_cities = City.where(is_hot: true)
  end

  def cities_search
    query = params[:query]

    cities = City.or(name: /#{query}/).or(english: /#{query}/).page(params[:page]).per(params[:per])

    render json: {data: cities.pluck(:name)}.to_json
  end
end

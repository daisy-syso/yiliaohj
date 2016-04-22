module Frontend
  class SearchesController < FrontendController
    def index
      @hot_words = HotWord.all.desc(:created_at).limit(8)
    end

    def create
      type = params[:type]
      word = params[:word]

      @results = type.present? ? type.classify.constantize.where(name: /#{word}/).page(params[:page]).per(10) : []

      response = @results.collect do |result|
        { name: result.name, url: "/#{type.pluralize}/#{result.id}" }
      end
      render json: { results: response }
    end
  end
end

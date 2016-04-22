module SearchService
  def self.search(params, klass)
    query = Jbuilder.encode do |json|
      json.query do
        json.filtered do
          json.filter do
            json.bool do
              json.must "search_service/#{klass}_filters".camelcase.constantize.new(params[:filters]).filters
            end
          end
        end
      end

      json.sort SearchSort.new(params[:sort_type], params[:location]).sort
    end

    klass.to_s.camelcase.constantize.search(query).page(params[:page]).per(params[:per])
  end
end

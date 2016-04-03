module HospitalService
  def self.filter(params)
    query = Jbuilder.encode do |json|
      json.query do
        json.filtered do
          json.filter do
            json.bool do
              json.must HospitalFilters.new(params[:filters]).filters
            end
          end
        end
      end

      json.sort HospitalSort.new(params[:sort_type]).sort
    end

    Hospital.search(query).page(params[:page]).per(params[:per])
  end
end
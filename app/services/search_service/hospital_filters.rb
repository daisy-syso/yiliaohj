module SearchService
  class HospitalFilters < BaseFilter
    private

    def category_filter
      return if filter_criteria[:category].blank?
      @filters << { term: { category: filter_criteria[:category] } }
    end

    def location_filter
      @filters << {
        geo_distance: {
          distance: '300km',
          location: {
            lat: filter_criteria[:location][:lat],
            lon: filter_criteria[:location][:lon]
          }
        }
      }
    end

    def medical_insurance_filter
      return if filter_criteria[:medical_insurance].blank?

      @filters << { term: { is_medical_insurance: filter_criteria[:medical_insurance] } }
    end

    def level_filter
      return if filter_criteria[:level].blank?
      @filters << { term: { level: filter_criteria[:level] } }
    end
  end
end

module HospitalService
  class HospitalFilters
    attr_reader :filter_criteria, :filters

    def initialize(filter_criteria)
      @filter_criteria = filter_criteria
      @filters = []
      generate_filters
    end

    private

    def generate_filters
      filter_criteria.keys.each do |key|
        send(:"#{key}_filter")
      end
    end

    def category_filter
      return if filter_criteria[:category].blank?
      hospital_category = HospitalCategory.includes(:children).where(id: filter_criteria[:category]).first
      return if hospital_category.blank?

      if hospital_category.parent.present?
        @filters << {term: {hospital_category_id: hospital_category.id.to_s}}
      else
        ids = hospital_category.children.map{|hc| hc.id.to_s}
        @filters << {terms: {hospital_category_id: ids}}
      end
    end

    def location_filter
      return
    end

    def medical_insurance_filter
      return if filter_criteria[:medical_insurance].blank?

      @filters << {term: {is_medical_insurance: filter_criteria[:medical_insurance]}}
    end

  end
end
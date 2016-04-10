module SearchService
  class BaseFilter
    attr_reader :filter_criteria, :filters

    def initialize(filter_criteria)
      @filter_criteria = filter_criteria || {}
      @filters = []
      generate_filters
    end

    private

    def generate_filters
      filter_criteria.keys.each do |key|
        send(:"#{key}_filter")
      end
    end
  end
end
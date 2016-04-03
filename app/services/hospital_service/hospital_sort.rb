module HospitalService
  class HospitalSort
    def initialize(sort_type)
      @sort_type = sort_type
    end

    def sort
      case @sort_type
        when 'publish_near'
          {created_at: {order: 'desc', missing: '_last'}}
        when 'click_count'
          {click_count: {order: 'desc', missing: '_last'}}
        when 'hot_top'
          {star: {order: 'desc', missing: '_last'}}
      end
    end
  end
end
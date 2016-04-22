module SearchService
  class SearchSort
    def initialize(sort_type, location)
      @sort_type = sort_type
      @location = location
    end

    def sort
      case @sort_type
      when 'publish_near'
        { created_at: { order: 'desc', missing: '_last' } }
      when 'click_count'
        { click_count: { order: 'desc', missing: '_last' } }
      when 'hot_top'
        { star: { order: 'desc', missing: '_last' } }
      when 'neighbour'
        {
          _geo_distance: {
            location: {
              lat: @location[:lat],
              lon: @location[:lon]
            },
            order: 'asc',
            unit: 'km',
            distance_type: 'plane'
          }
        }
      when 'character'
        { name: { order: 'asc', missing: '_last' } }
      when 'price_desc'
        { price: { order: 'desc', missing: '_last' } }
      when 'price_asc'
        { price: { order: 'asc', missing: '_last' } }
      end
    end
  end
end

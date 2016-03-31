module Elasticsearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    __elasticsearch__.client =
      Elasticsearch::Client.new hosts: Settings.elasticsearch.hosts, logger: Logger.new(Rails.root.join Settings.elasticsearch.log)
  end

  class_methods do
    def neighbour(lat, lon, distance)
      query = {
          query: {
              filtered: {
                  filter: {
                      geo_distance: {
                          distance: distance,
                          location: {
                              lat: lat,
                              lon: lon
                          }
                      }
                  }
              }
          },
          sort: [
              {
                  _geo_distance: {
                      location: {
                          lat:  lat,
                          lon: lon
                      },
                      order: 'asc',
                      unit: 'km',
                      distance_type: 'plane'
                  }
              }
          ]
      }
      search query
      # User.neighbour(31.018188,121.196511,'12000km').response
    end
  end
end

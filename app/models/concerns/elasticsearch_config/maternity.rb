module ElasticsearchConfig
  module Maternity
    extend ActiveSupport::Concern

    included do
      include Elasticsearchable

      index_name    "yiliao-maternities-#{Rails.env}"
      document_type 'maternities'

      settings index: { number_of_shards: 5 } do
        mappings do
          indexes :telephone, type: 'string', index: :not_analyzed, analyzer: :keyword
          indexes :name, type: 'string'
          indexes :location, type: 'geo_point'
        end
      end
    end

    def as_indexed_json(option = {})
      {
        id: id.to_s,
        name: name,
        telephone: telephone,
        location: location
      }.as_json(option)
    end
  end
end

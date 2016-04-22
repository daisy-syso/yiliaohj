module ElasticsearchConfig
  module Medical
    extend ActiveSupport::Concern

    included do
      include Elasticsearchable

      index_name    "yiliao-medicals-#{Rails.env}"
      document_type 'medicals'

      settings index: { number_of_shards: 5 } do
        mappings do
          indexes :telephone, type: 'string', index: :not_analyzed, analyzer: :keyword
          indexes :location, type: 'geo_point'
          indexes :created_at, type: 'date', format: 'date_time'
          indexes :click_count, type: 'integer'
          indexes :star, type: 'integer'
          indexes :price, type: 'Float'
        end
      end
    end

    def as_indexed_json(option = {})
      {
        id: id.to_s,
        telephone: telephone,
        location: location,
        created_at: created_at,
        click_count: click_count,
        star: star,
        price: price
      }.as_json(option)
    end
  end
end

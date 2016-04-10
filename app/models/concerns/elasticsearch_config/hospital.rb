module ElasticsearchConfig
  module Hospital
    extend ActiveSupport::Concern

    included do
      include Elasticsearchable

      index_name    "yiliao-hospitals-#{Rails.env}"
      document_type 'hospitals'

      settings index: { number_of_shards: 5 } do
        mappings do
          indexes :telephone, type: 'string', index: :not_analyzed, analyzer: :keyword
          indexes :name, type: 'string'
          indexes :location, type: 'geo_point'
          indexes :category, type: 'string', index: :not_analyzed, analyzer: :keyword
          indexes :level, type: 'string', index: :not_analyzed, analyzer: :keyword
          indexes :city_name, type: 'string', index: :not_analyzed, analyzer: :keyword
          indexes :is_medical_insurance, type: 'boolean'
          indexes :created_at, type: 'date', format: 'date_time'
          indexes :click_count, type: 'integer'
          indexes :star, type: 'integer'
        end
      end
    end

    def as_indexed_json(option = {})
      {
          id: id.to_s,
          name: name,
          telephone: telephone,
          location: location,
          category: category,
          level: level,
          city_name: city.try(:name).to_s,
          is_medical_insurance: is_medical_insurance,
          created_at: created_at,
          click_count: click_count,
          star: star
      }.as_json(option)
    end
  end
end

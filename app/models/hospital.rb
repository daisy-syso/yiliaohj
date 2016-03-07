# 医院
class Hospital
  include Mongoid::Document
  include Mongoid::Timestamps
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :description, type: String
  field :telephone, type: String
  field :address, type: String
  field :image_url, type: String
  field :url, type: String

  field :characteristic_departments, type: String
  field :level, type: String
  field :location, type: String

  field :click_count, type: String

  field :star, type: Integer, default: 3
  field :status, type: Boolean, default: true

  field :is_medical_insurance, type: Boolean

  belongs_to :city
  belongs_to :county

  has_many :departments
  has_many :doctors

  has_many :comments, as: :commentable
  has_many :examinations, as: :examinationable
  has_many :recommendations, as: :recommendationable

  validates :name, presence: true
  validates :telephone, presence: true
  validates :address, presence: true

  index name: 1

  index_name    "yiliao-hospitals-#{Rails.env}"
  document_type 'hospitals'

  settings index: { number_of_shards: 5 } do
    mappings do
      indexes :telephone, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :location, type: 'geo_point'
    end
  end

  def as_indexed_json(option = {})
    {
      id: id.to_s,
      telephone: telephone,
      location: location
    }.as_json(option)
  end

  def self.neighbour(lat, lon, distance)
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

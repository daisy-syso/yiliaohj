# 药店
class DrugStore
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :address, type: String
  field :description, type: String
  field :position, type: String
  field :drug_category, type: String
  field :location, type: String
  field :lon, type: Float
  field :lat, type: Float
  field :telephone, type: String
  field :image_url, type: String
  field :url, type: String
  field :click_count, type: String
  field :star, type: Integer
  field :status, type: Boolean

  field :open_time, type: String
  field :license, type: String
  field :business_license, type: String
  field :gsp, type: String

  belongs_to :city
  belongs_to :county

  validates :name, presence: true

  index name: 1
end

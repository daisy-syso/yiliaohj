# 器械
class Instrument
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :drug_store
  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :description, type: String
  field :origin_price, type: Float
  field :price, type: Float
  field :origin, type: String
  field :production_date, type: ActiveSupport::TimeWithZone
  field :image_url, type: String
  field :status, type: Boolean, default: true
  field :manufactory_name, type: String

  index name: 1
end

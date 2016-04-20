# 药品
class Drug
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :drug_store
  embeds_many :drug_details
  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :origin_price, type: Float
  field :price, type: Float
  field :description, type: String
  field :image_url, type: String
  field :brand, type: String
  field :expory_date, type: String
  field :code, type: String
  field :spec, type: String
  field :status, type: Boolean, default: true
  field :manufactory_name, type: String
  field :drug_category, type: String

  index name: 1
end

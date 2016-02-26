# 药品
class Drug
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :manufactory, type: String

  field :origin_price, type: Float
  field :price, type: Float

  field :description, type: String

  field :image_url, type: String

  field :brand, type: String

  field :expory_date, type: String
  field :code, type: Integer
  field :spec, type: String

  field :status, type: Boolean, default: true

  field :diseases, type: Array, default: -> { [] }

  has_many :drug_detail

  validates :name, presence: true

  index name: 1
end

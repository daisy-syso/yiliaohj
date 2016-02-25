# 月子会所
class Maternal
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :telephone, type: String
  field :address, type: String
  field :image_url, type: String

  field :origin_price, type: Float
  field :price, type: Float

  field :lon, type: Float
  field :lat, type: Float

  field :click_count, type: String

  field :star, type: Integer
  field :status, type: Boolean

  belongs_to :city
  belongs_to :county

  has_many :comments, as: :commentable

  validates :name, presence: true
  validates :telephone, presence: true
  validates :address, presence: true

  index name: 1
end


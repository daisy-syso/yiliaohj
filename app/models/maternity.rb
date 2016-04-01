# 母婴会所
class Maternity
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::Maternal

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :telephone, type: String
  field :address, type: String
  field :image_url, type: String
  field :location, type: String

  field :origin_price, type: Float
  field :price, type: Float

  field :location, type: String

  field :click_count, type: Integer

  field :star, type: Integer
  field :status, type: Boolean

  belongs_to :city
  belongs_to :county

  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  validates :name, presence: true
  validates :telephone, presence: true
  validates :address, presence: true

  index name: 1
end

# 母婴会所
class Maternity
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::Maternal

  belongs_to :city
  belongs_to :county
  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :telephone, type: String
  field :address, type: String
  field :image_url, type: String
  field :location, type: String
  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }

  field :origin_price, type: Float
  field :price, type: Float
  field :click_count, type: Integer
  field :star, type: Integer
  field :status, type: Boolean

  field :geo_near_distance, type: Float, default: 0.0

  validates :name, presence: true
  validates :telephone, presence: true
  validates :address, presence: true

  index(coordinates: '2dsphere')
  index name: 1
  index click_count: 1
  index star: 1

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end

  def visit!
    self.click_count += 1
    save
  end

  index name: 1
end

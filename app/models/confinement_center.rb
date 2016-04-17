# 月子中心
class ConfinementCenter
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::Maternal

  belongs_to :city, index: true
  belongs_to :county, index: true
  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :telephone, type: String
  field :address, type: String
  field :image_url, type: String
  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }
  field :location, type: String
  field :origin_price, type: Float
  field :price, type: Float
  field :location, type: String
  field :click_count, type: Integer
  field :star, type: Integer
  field :status, type: Boolean

  validates :name, :telephone, :address, presence: true

  index name: 1
  index({ coordinates: '2dsphere' })

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end
end

# 体检中心
class Medical
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::Madical

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

  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }
  field :location, type: String

  field :origin_price, type: Float
  field :price, type: Float

  field :click_count, type: Integer

  field :star, type: Integer
  field :status, type: Boolean

  validates :name, presence: true
  validates :telephone, presence: true
  validates :address, presence: true

  # has_many :examinations, as: :examinationable

  has_many :examinations

  index({ coordinates: '2dsphere' })
  index name: 1
  index click_count: 1
  index star: 1

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end
end

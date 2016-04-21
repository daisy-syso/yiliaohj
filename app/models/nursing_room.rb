# 敬老院
class NursingRoom
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::NursingRoom

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :telephone, type: String

  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }
  field :location, type: String

  field :image_url, type: String
  field :address, type: String

  field :price, type: String
  field :url, type: String
  field :bed, type: Integer

  # field :mold, type: String
  # field :nature, type: String

  field :description, type: String
  field :service, type: String

  field :target, type: String

  field :click_count, type: Integer
  field :star, type: Integer
  field :status, type: Boolean

  # true 公办 false 民办
  field :is_public, type: Boolean, default: false

  # true 公寓 false 敬老院
  field :is_apartment, type: Boolean, default: false

  belongs_to :city
  belongs_to :county

  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  validates :name, presence: true
  validates :telephone, presence: true
  validates :address, presence: true

  index name: 1
  index click_count: 1
  index star: 1
  index({ coordinates: '2dsphere' })

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end
end

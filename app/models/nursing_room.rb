# 敬老院
class NursingRoom
  include Mongoid::Document
  include Mongoid::Timestamps
  include ElasticsearchConfig::NursingRoom

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :telephone, type: String
  field :location, type: String

  field :image_url, type: String
  field :address, type: String

  field :location, type: String

  field :price, type: String
  field :url, type: String
  field :bed, type: Integer

  field :mold, type: String
  field :nature, type: String

  field :description, type: String
  field :service, type: String

  field :target, type: String

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

# 医院
class Hospital
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::Hospital

  belongs_to :city
  belongs_to :county
  has_many :doctors
  has_many :comments, as: :commentable
  # has_many :recommendations, as: :recommendationable
  has_and_belongs_to_many :departments

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :description, type: String
  field :telephone, type: String
  field :address, type: String
  field :image_url, type: String
  field :url, type: String
  field :characteristic_departments, type: String
  field :level, type: String
  field :location, type: String
  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }
  field :lat, type: Float
  field :lon, type: Float
  field :click_count, type: Integer, default: 0
  field :star, type: Integer, default: 3
  field :status, type: Boolean, default: true
  field :is_medical_insurance, type: Boolean
  field :categories, type: Array, default: -> { [] }

  # 海外医疗值填写为true
  field :is_foreign, type: Boolean, default: false

  # 肿瘤医院值填写为true
  field :id_tumour, type: Boolean, default: false

  validates :name, presence: true
  # validates :telephone, presence: true
  # validates :address, presence: true

  field :geo_near_distance, type: Float, default: 0.0

  index(coordinates: '2dsphere')
  # index({ coordinates: '2d' })
  index name: 1
  index level: 1
  index click_count: 1
  index star: 1

  def visit!
    self.click_count += 1
    save
  end

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end
end

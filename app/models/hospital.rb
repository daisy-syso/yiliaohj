# 医院
class Hospital
  include Mongoid::Document
  include Mongoid::Timestamps
  # include ElasticsearchConfig::Hospital

  belongs_to :city
  belongs_to :county
  has_many :doctors
  has_many :comments, as: :commentable
  has_many :recommendations, as: :recommendationable
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
  field :lat, type: Float
  field :lon, type: Float
  field :click_count, type: Integer
  field :star, type: Integer, default: 3
  field :status, type: Boolean, default: true
  field :is_medical_insurance, type: Boolean
  field :category, type: String

  validates :name, presence: true
  # validates :telephone, presence: true
  # validates :address, presence: true

  index name: 1
  index level: 1
  index click_count: 1
  index star: 1

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end
end

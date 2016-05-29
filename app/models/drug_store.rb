# 药店
class DrugStore
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :drugs, index: true

  belongs_to :city
  belongs_to :county
  belongs_to :drug_store_admin
  has_many :instruments
  has_many :comments, as: :commentable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :address, type: String
  field :description, type: String
  field :position, type: String
  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }
  field :location, type: String
  field :lon, type: Float
  field :lat, type: Float
  field :telephone, type: String
  field :image_url, type: String
  field :url, type: String
  field :click_count, type: Integer, default: 0
  field :star, type: Integer
  field :status, type: Boolean

  field :open_time, type: String
  field :license, type: String
  field :business_license, type: String
  field :gsp, type: String

  field :is_24, type: Boolean, default: true
  field :is_online, type: Boolean, default: false
  field :is_medical_insurance, type: Boolean, default: false
  field :is_transport, type: Boolean, default: false
  field :scope_of_business, type: String

  validates :name, presence: true

  index(coordinates: '2dsphere')
  index name: 1
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

# 保险公司
class InsuranceCompany
  include Mongoid::Document
  include Mongoid::Timestamps

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
  field :location, type: String, default: '0,0'
  field :url, type: String
  # [longitude,latitude]
  field :coordinates, type: Array, default: -> { [] }
  field :click_count, type: Integer, default: 0
  field :star, type: Integer

  index(coordinates: '2dsphere')
  index name: 1
  index click_count: 1
  index star: 1
end

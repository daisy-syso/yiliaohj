# 保险
class Insurance
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :label, type: String
  field :insurance_type, type: String
  field :price, type: Float
  field :suitable_age, type: String
  field :expiry_date, type: String
  field :url, type: String
  field :image_url, type: String

  field :star, type: Integer
  field :status, type: Boolean

  field :company_name, type: String
  field :company_url, type: String
  field :category, type: String

  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  index name: 1
end

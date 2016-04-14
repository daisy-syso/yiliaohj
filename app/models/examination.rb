# 体检套餐
class Examination
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :medical
  embeds_many :examination_details
  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :origin_price, type: Float
  field :price, type: Float
  field :image_url, type: String
  field :feature, type: String
  field :applicable, type: String
  field :category, type: String

end

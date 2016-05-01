# 套餐
class Buffet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :department

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :description, type: String
  field :min_price, type: String
  field :max_price, type: String
  field :image_url, type: String

end

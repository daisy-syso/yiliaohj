# 套餐
class Buffet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :group_buying
  belongs_to :hospital
  belongs_to :hospital_category

  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :image_url, type: String
  field :name, type: String
  field :origin_price, type: Integer
  field :price, type: Integer
  field :description, type: String
  field :click_count, type: Integer
  field :star, type: Integer

  field :group_buying_name, type: String

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
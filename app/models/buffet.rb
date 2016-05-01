# 套餐
class Buffet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :group_buying
  belongs_to :hospital

  mount_uploader :image_url, PictureUploader

  field :image_url, type: String
  field :name, type: String
  field :origin_price, type: Integer
  field :price, type: Integer
  field :description, type: String
  field :click_count, type: Integer
  field :star, type: Integer

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
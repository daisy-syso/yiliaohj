# 保险
class Insurance
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  belongs_to :insurance_company

  field :gender, type: String
  field :calssification, type: String
  field :charateristic, type: String
  field :age, type: String
  field :quota, type: String
  field :name, type: String

  field :expiry_date, type: String

  field :origin_price, type: Float
  field :price, type: Float

  field :description, type: String

  field :image_url, type: String

  field :star, type: Integer
  field :click_count, type: Integer
  field :status, type: Boolean

  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

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

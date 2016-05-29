# 药品
class Drug
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :drug_name
  has_and_belongs_to_many :drug_stores, index: true

  embeds_many :drug_details
  has_many :comments, as: :commentable
  has_many :commodities, as: :commoditiable

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :origin_price, type: Float
  field :price, type: Float
  field :description, type: String
  field :image_url, type: String
  field :brand, type: String
  field :expory_date, type: String
  field :code, type: String
  field :spec, type: String
  field :status, type: Boolean, default: true
  field :manufactory_name, type: String
  field :drug_category, type: String
  field :click_count, type: Integer, default: 0
  field :star, type: Integer, default: 0

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

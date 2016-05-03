# 进口保健品
class ImportDrug
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :import_drug_category
  has_many :comments, as: :commentable

  mount_uploader :image_url, PictureUploader

  field :image_url, type: String
  field :name, type: String
  field :brand, type: String
  field :country_name, type: String
  field :spec, type: String
  field :origin_price, type: String
  field :price, type: String
  field :description, type: String
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

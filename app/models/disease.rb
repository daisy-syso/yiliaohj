# 疾病
class Disease
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :etiology, type: String
  field :symptom, type: String
  field :examination, type: String
  field :treatent, type: String
  field :prevention, type: String
  field :diet, type: String
  field :image_url, type: String
  field :description, type: String

  belongs_to :department

  validates :name, presence: true

  index name: 1
end

# 症状详情
class SymptomDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :descripton, type: String
  field :image_url, type: String

  belongs_to :symptom
end


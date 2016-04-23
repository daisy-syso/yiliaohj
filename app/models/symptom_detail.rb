# 症状详情
class SymptomDetail
  include Mongoid::Document

  embedded_in :symptom

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :descripton, type: String
  field :image_url, type: String
end

# 症状详情
class SymptomDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :symptom

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :description, type: String
  field :image_url, type: String
end

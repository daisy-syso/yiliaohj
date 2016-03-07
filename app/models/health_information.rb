# 反馈
class HealthInformation
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :image_url, type: String
  field :link, type: String
  
  # field :information_id, type: String
end

# 首页进口药
class ImportDrug
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :image_url, type: String
  field :link, type: String
end

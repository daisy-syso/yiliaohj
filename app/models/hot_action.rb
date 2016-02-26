# 热门活动
class HotAction
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :image_url, type: String
  field :link, type: String

  validates :title, uniqueness: true, presence: true
end

# 热门活动
class HotAction
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :title, type: String
  field :image_url, type: String
  field :link, type: String
end
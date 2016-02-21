# 首页轮播图
class Banner
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :title, type: String
  field :image_url, type: String
  field :link, type: String
end
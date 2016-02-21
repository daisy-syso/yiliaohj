# 分类
class Category
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :title, type: String
  field :image_url, type: String
  field :link, type: String
  field :order, type: Integer

end
# 首页进口药
class ImportDrug
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :title, type: String
  field :image_url, type: String
  field :link, type: String
end
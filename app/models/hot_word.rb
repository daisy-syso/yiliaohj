# 热门搜索
class HotWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :type, type: String
  field :typeid, type: String
end

# 广告
class Advertisement
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  # hospital, doctor, other
  field :type, type: String
  field :type_id, type: String
  field :link, type: String
end

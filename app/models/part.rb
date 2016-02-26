# 部位
class Part
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :symptoms
end

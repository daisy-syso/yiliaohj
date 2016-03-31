# 商品
class Commodity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, index: true
  belongs_to :commoditiable, polymorphic: true, index: true

  field :count, type: Integer
  field :price, type: Float
end

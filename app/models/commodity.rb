# 商品
class Commodity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :commoditiable, polymorphic: true

  field :count, type: Integer
  field :price, type: Float
end

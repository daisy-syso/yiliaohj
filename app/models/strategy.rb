# 攻略
class Strategy
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :sub_title, type: String
  field :content, type: String

  belongs_to :strategy_category
end

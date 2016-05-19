# 攻略 分类
class StrategyCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parent, class_name: 'StrategyCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'StrategyCategory', inverse_of: :parent

  field :name, type: String

  has_many :strategies
end

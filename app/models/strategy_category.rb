# 攻略 分类
class StrategyCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parent, class_name: 'StrategyCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'StrategyCategory', inverse_of: :parent

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :image_url, type: String, default: ''

  has_many :strategies
end

# 订阅分类
class SubscriptionCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parent, class_name: 'InformationCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'InformationCategory', inverse_of: :parent

  field :name, type: String

  has_and_belongs_to_many :subscriptions
  has_many :information
end

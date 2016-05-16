# 订阅分类
class SubscriptionCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parent, class_name: 'SubscriptionCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'SubscriptionCategory', inverse_of: :parent

  mount_uploader :image_url, PictureUploader

  field :name, type: String

  field :image_url, type: String
  field :information_ids, type: Array, default: -> { [] }

  has_and_belongs_to_many :subscriptions
end

# 订阅
class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps

  # field :name, type: String

  belongs_to :user
  has_and_belongs_to_many :information_categories

  # before_save do
  #   self.name = InformationCategory.find(InformationCategory.find(information_category_id).parent_id).name
  # end
end

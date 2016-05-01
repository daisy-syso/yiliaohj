# 团购
class GroupBuying
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :department
  has_many :buffets

  field :name, type: String
  field :description, type: String
end
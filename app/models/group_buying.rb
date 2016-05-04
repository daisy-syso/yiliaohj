# 团购
class GroupBuying
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :hospital_category
  has_many :buffets

  field :name, type: String
  field :description, type: String
end
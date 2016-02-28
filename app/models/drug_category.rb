# 药品类型
class DrugCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parent, class_name: "DrugCategory"
  has_many :children, class_name: "DrugCategory"

  field :name, type: String

  belongs_to :drug
end

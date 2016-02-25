# 药品类型
class DrugType
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String

  belongs_to :drug
end
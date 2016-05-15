# 进口保健品分类
class ImportDrugCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :import_drugs

  field :name, type: String

  belongs_to :parent, class_name: 'ImportDrugCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'ImportDrugCategory', inverse_of: :parent
end

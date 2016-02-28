# 疾病信息类型
class DiseaseInfoCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :parent, class_name: "DiseaseInfoCategory"
  has_many :children, class_name: "DiseaseInfoCategory"

  has_many :information

end

# 体检类别
class ExaminationCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :parent, class_name: 'ExaminationCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'ExaminationCategory', inverse_of: :parent
end

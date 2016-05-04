# 医院 类别
class HospitalCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :parent, class_name: 'HospitalCategory', inverse_of: :children, index: true
  has_many :children, class_name: 'HospitalCategory', inverse_of: :parent

  # has_many :hospitals
  has_many :buffets
end

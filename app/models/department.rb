# 医院部门
class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :doctors
  has_many :diseases
  has_many :group_buyings
  has_and_belongs_to_many :hospitals
  belongs_to :parent, class_name: 'Department', inverse_of: :children, index: true
  has_many :children, class_name: 'Department', inverse_of: :parent

  field :name, type: String
end

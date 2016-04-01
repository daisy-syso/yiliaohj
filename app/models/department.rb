# 医院部门
class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :parent_department, class_name: 'Department', inverse_of: :child_departments, index: true
  has_many :child_departments, class_name: 'Department', inverse_of: :parent_department

  has_many :doctors
  has_many :diseases

  belongs_to :hospital, index: true
end

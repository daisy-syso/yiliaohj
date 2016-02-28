# 医院部门
class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :parent, class_name: "Department"
  has_many :children, class_name: "Department"

  has_many :doctors
  has_many :diseases

  belongs_to :hospital
end

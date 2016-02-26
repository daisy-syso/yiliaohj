# 医院部门
class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :doctors
  has_many :diseases

  belongs_to :hospital
end

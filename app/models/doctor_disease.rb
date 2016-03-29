# 医生疾病关系表
class DoctorDisease
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :doctor
  belongs_to :disease

  field :vote, type: Integer, default: 0
end

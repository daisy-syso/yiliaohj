# 体检类别
class ExaminationCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :examinations
end

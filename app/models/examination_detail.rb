# 体检套餐
class ExaminationDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String

  belongs_to :examination
end
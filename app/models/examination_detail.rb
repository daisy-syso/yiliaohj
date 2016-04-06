# 体检套餐
class ExaminationDetail
  include Mongoid::Document

  embedded_in :examination

  field :title, type: String
  field :content, type: String
end

# 药品详情
class DrugDetail
  include Mongoid::Document

  embedded_in :drug

  field :title, type: String
  field :detail, type: String
end

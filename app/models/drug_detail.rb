# 药品详情
class DrugDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :detail, type: String

  belongs_to :drug_name
end

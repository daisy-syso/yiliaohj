# 保险公司
class InsuranceCompany
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String
end

# 体检中心
class Medical
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :telephone, type: String
  field :location, type: String

  has_many :examinations, as: :examinationable
end

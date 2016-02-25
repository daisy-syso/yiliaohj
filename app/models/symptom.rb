# 症状
class Symptom
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :common_examination, type: String
  field :common_symptom, type: String
  field :common_drug, type: String
  field :common_disease, type: String

  has_many :symptom_details
  belongs_to :part
end
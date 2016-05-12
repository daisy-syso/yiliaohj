# 症状
class Symptom
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :part
  embeds_many :symptom_details

  field :name, type: String
  field :english, type: String
  field :common_examination, type: String
  field :common_symptom, type: String
  field :common_drug, type: String
  field :common_disease, type: String
  field :display_index, type: Integer, default: 0
end

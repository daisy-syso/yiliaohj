# 市级
class City
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :english, type: String
  field :english_all, type: String
  field :is_hot, type: Boolean, default: false

  belongs_to :provience, index: true
  has_many :counties

  has_many :hospitals
  has_many :maternities
  has_many :drug_stores
  has_many :nursing_rooms
end

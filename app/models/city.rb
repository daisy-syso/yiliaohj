# 市级
class City
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :provience

  has_many :counties
  has_many :hospitals

  has_many :maternals
  has_many :drug_stores
  has_many :nursing_rooms

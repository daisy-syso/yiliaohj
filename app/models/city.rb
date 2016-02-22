# 市级
class City
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :name, type: String

  embeds_many :counties
  belongs_to :provience

  has_many :hospitals
end
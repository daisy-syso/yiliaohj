# 区县
class County
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :city, index: true

  has_many :hospitals
  has_many :maternities
  has_many :drug_stores
  has_many :nursing_rooms
end

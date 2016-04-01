# 省份
class Province
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :country
  has_many :cities
end

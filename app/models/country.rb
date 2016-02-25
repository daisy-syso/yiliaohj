# 国家
class Country
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :proviences
end
# 区县
class County
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :city

  has_many :hospitals
end
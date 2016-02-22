# 区县
class County
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :name, type: String

  embedded_in :city

  has_many :hospitals
end
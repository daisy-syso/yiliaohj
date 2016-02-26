# 体检
class Medical
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :name, type: String
end
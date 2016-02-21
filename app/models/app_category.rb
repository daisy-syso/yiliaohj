# App 类别
class AppCategory
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :name, type: String
  
  embeds_many :apps
end
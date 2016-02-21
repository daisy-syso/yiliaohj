# App
class App
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :name, type: String
  field :image_url, type: String
  field :link, type: String
  field :detail, type: String
  
  embedded_in :app_category
end
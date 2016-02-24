# App
class App
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :image_url, type: String
  field :link, type: String
  field :detail, type: String
  
  belongs_to :app_category
end
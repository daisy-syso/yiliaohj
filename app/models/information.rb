# Information
class Information
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :title, type: String
  field :content, type: String
  field :source, type: String
  field :image_url, type: String
  field :click_count, type: Integer

  belongs_to :information_category
end

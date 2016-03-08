# Information
class Information
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :content, type: String

  belongs_to :disease_info_category
end
# 进口药
class ImportDrug
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :import_drug_category

  mount_uploader :image_url, PictureUploader

  field :image_url, type: String
  field :name, type: String
  field :brand, type: String
  field :country_name, type: String
  field :spec, type: String
  field :origin_price, type: String
  field :price, type: String
  field :description, type: String

end

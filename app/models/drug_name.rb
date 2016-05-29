# 药品名称
class DrugName
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :drugs

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :image_url, type: String
  field :brand, type: String
  field :code, type: String
  field :spec, type: String
  # 价格范围 [25, 60]
  field :price_high, type: Integer
  field :price_low, type: Integer
  # field :price_range, type: Array, default: -> {[]}
  # 药品分类
  field :drug_category, type: String
  # 疾病名称
  field :disease_names, type: Array, default: -> {[]}
  # 推广的药品ID
  field :recommand_drug_id, type: String
end

# 药店管理员
class DrugStoreAdmin
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :avatar, PictureUploader

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :avatar, type: String
  field :gender, type: String, default: '男'
  field :telephone, type: String
  field :nickname, type: String

  has_many :drug_stores
end

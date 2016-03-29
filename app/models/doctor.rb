# 医生
class Doctor
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :summary, type: String
  field :nationality, type: String
  field :description, type: String
  field :position, type: String
  field :telephone, type: String
  field :image_url, type: String
  field :url, type: String
  field :click_count, type: String
  field :star, type: Integer
  field :room, type: String
  field :status, type: Boolean
  field :person_website, type: String
  field :is_home_visit, type: Boolean, default: false

  belongs_to :hospital
  belongs_to :department

  has_many :comments, as: :commentable

  validates :name, presence: true

  index name: 1

  # has_many :doctor_diseases
  # has_and_belongs_to_many :diseases
  # has_many :diseases, through: :doctor_diseases

  has_many :doctor_diseases

  def diseases
    Disease.in(id: doctor_diseases.pluck(:disease_id))
  end

  def category_star!
    score = comments.pluck(:rating).compact.sum
    member = comments.size
    self.star = (score / member).to_i
    save
  end
end

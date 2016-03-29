# 疾病
class Disease
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :etiology, type: String
  field :symptom, type: String
  field :examination, type: String
  field :treatent, type: String
  field :prevention, type: String
  field :diet, type: String
  field :image_url, type: String
  field :description, type: String

  belongs_to :department

  has_many :doctor_diseases

  def doctors
    Doctor.in(id: doctor_diseases.pluck(:doctor_id))
  end

  # has_many :doctors, through: :doctor_diseases
  # has_and_belongs_to_many :doctors

  validates :name, presence: true

  index name: 1
end

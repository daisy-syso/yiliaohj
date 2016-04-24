# 疾病
class Disease
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :department, index: true
  has_many :doctor_diseases

  mount_uploader :image_url, PictureUploader

  field :name, type: String
  field :etiology, type: String
  field :symptom, type: String
  field :examination, type: String

  # treatment   导入错误
  field :treatent, type: String
  field :prevention, type: String

  field :diet, type: String
  field :image_url, type: String
  field :description, type: String
  field :drug_names, type: Array, default: -> { [] }

  def doctors
    Doctor.in(id: doctor_diseases.pluck(:doctor_id))
  end

  validates :name, presence: true

  index name: 1
  index created_at: 1
end

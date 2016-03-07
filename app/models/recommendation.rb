class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  # hospital, doctor, other
  # field :type, type: String
  # field :type_Id, type: String

  belongs_to :recommendationable, polymorphic: true
  # has_many :doctors
end

class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  # hospital, doctor, other
  field :recommendationable_type, type: String
  field :recommendationable_id, type: String

  # belongs_to :recommendationable, polymorphic: true
  # has_many :doctors
end

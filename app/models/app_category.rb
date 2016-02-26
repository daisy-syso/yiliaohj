# App 类别
class AppCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :apps, dependent: :destroy
end

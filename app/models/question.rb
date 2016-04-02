# 用户问题
class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :category, type: String
  field :telephone, type: String
  field :email, type: String

  belongs_to :user
  has_many :answers
end

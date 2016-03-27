# 评论
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :rating, type: Integer, default: 1

  belongs_to :user

  belongs_to :commentable, polymorphic: true
end

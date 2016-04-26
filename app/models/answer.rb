# 回答
class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :question

  field :content, type: String
end

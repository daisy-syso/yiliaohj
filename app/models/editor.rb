require 'bcrypt'

class Editor
  include Mongoid::Document
  include Mongoid::Timestamps
  
  validates :username, uniqueness: true, length: { in: 3..14 }
  validates :password, presence: true, length: {minimum: 6}

  include BCrypt

  field :username, type: String
  field :email, type: String
  field :telephone, type: String
  field :password_hash, type: String
  field :authentication_token, type: String

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
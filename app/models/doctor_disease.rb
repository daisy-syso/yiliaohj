# 医生疾病关系表
class DoctorDisease
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Objects

  belongs_to :doctor, index: true
  belongs_to :disease, index: true

  set :voters
  delegate :count, to: :voters, prefix: true

  def change_like!(user)
    user_id = user.id.to_s
    if voters.member? user_id
      voters.delete user_id
    else
      voters << user_id
    end
  end
end

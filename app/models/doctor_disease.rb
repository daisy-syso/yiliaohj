# 医生疾病关系表
class DoctorDisease
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :doctor
  belongs_to :disease

  field :votes, type: Integer, default: 0
  field :voted_by, type: Array, default: -> {[]}

  def voted_by?(user)
    voted_by.include? user.try(:id).to_s
  end

  def change_like!(user)
    user_id = user.id.to_s
    if voted_by.include? user_id
      voted_by.delete user_id
    else
      voted_by << user_id
    end
    self.votes = voted_by.size
    save
  end
end

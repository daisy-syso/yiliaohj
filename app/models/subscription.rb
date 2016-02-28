# 订阅
class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  has_one :disease_info_category

  before_save do
    self.top_name = DiseaseInfoCategory.find(DiseaseInfoCategory.find(self.disease_info_category_id).parent_id).name
  end
end

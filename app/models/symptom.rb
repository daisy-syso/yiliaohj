# 症状
class Symptom
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :part
  embeds_many :symptom_details

  field :name, type: String
  field :english, type: String
  field :common_examination, type: String
  field :common_symptom, type: String
  field :common_drug, type: String
  field :common_disease, type: String
  field :display_index, type: Integer, default: 0
  field :index_array, type: Array, default: []

  # callbacks
  before_save :init_index_array #after_create is before before_save
  def init_index_array
    if self.index_array.empty?
      self.index_array = PinYin.of_string(self.name)
    end
  end

  # class methods to init history data Use like this: Symptom.init_index_array
  class << self
    def init_index_array
      Symptom.each do |s|
        s.save
      end
    end
  end

end

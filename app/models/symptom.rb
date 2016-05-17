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
  field :index_string, type: String, default: nil

  # callbacks
  before_save :init_index_string #after_create is before before_save
  def init_index_string
    # if self.index_string.blank?
      self.index_string = PinYin.of_string(self.name).map do |item|
        item[0].downcase
      end.join('')
    # end
  end

  # class methods to init history data Use like this: Symptom.init_index_array
  class << self
    def init_index_string
      Symptom.each do |s|
        s.save
      end
    end
  end

end

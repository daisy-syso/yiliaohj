module Frontend
  class PersonCustomsController < FrontendController
    def index
      @information_categories = InformationCategory.where(name: '疾病').first.children
    end

    def question
      
    end
  end
end

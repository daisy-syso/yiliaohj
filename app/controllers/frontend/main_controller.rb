module Frontend
  class MainController < FrontendController
    def index
      @banners = Banner.all

      @categories = Category.all.desc(:order)
      @categories = [@categories.limit(16), @categories.offset(8).limit(8)]

      @advertisements = Advertisement.all

      @import_drugs = ImportDrug.all

      @hot_actions = HotAction.all.desc(:created_at).limit(6)
    end
  end
end

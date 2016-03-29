module Frontend
  class MaternalsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      @maternals = Maternal.all.page(params[:page]).per(params[:per])
    end

    def show
      @maternal = Maternal.find(params[:id])
    end
  end
end

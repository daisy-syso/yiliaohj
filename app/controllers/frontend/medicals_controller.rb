module Frontend
  class MedicalsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      @medicals = Medical.all.page(params[:page]).per(params[:per])
    end

    def show
      @medical = Medical.find(params[:id])
    end
  end
end

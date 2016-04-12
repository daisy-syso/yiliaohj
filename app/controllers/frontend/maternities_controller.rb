module Frontend
  class MaternitiesController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      @maternities = Maternity.all.page(params[:page]).per(params[:per])
    end

    def show
      @maternity = Maternity.find(params[:id])

      @comment = @maternity.comments.desc(:created_at).first
    end
  end
end

module Frontend
  class ExaminationsController < FrontendController
    def index
      query = {}
      @examinations = Examination.includes(:comments).includes(:commodities).where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'new'
          # 最近发布
          @examinations = @examinations.desc(:created_at)
        when 'star'
          # 评价最好
          @examinations = @examinations.desc(:star)
        when 'click_count'
          # 人气最高
          @examinations = @examinations.desc(:click_count)
        end
      end

      @examinations = @examinations.page(params[:page]).per(params[:per])
    end

    def show
      @examination = Examination.includes(:comments).find(params[:id])

      @examination.visit!

      @comment = @examination.comments.desc(:created_at).first
    end
  end
end

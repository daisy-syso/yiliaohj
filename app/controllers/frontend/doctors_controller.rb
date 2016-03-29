module Frontend
  class DoctorsController < FrontendController

    # 离我最近 最近发布 人气最高 评价最好
    def index
      @doctors = case params[:type]
                  when 'publish_near'
                    Doctor.all.desc(:created_at).page(params[:page]).per(params[:per])
                  when 'click_count'
                    Doctor.all.desc(:click_count).page(params[:page]).per(params[:per])
                  when 'hot_top'
                    Doctor.all.desc(:hot_top).page(params[:page]).per(params[:per])
                  else
                    Doctor.includes(:hospital).desc(:created_at).page(params[:page]).per(params[:per])
                  end
    end

    def show
      @doctor = Doctor.find(params[:id])

      @comment = @doctor.comments.desc(:created_at).first
    end
  end
end

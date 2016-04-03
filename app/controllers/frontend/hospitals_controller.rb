module Frontend
  class HospitalsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      @hospitals = HospitalService.filter(params).records.to_a
    end

    def show
      @hospital = Hospital.find(params[:id])

      @comment = @hospital.comments.desc(:created_at).first
    end
  end
end

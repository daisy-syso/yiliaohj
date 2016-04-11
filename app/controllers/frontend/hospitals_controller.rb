module Frontend
  class HospitalsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      # params ||= {}
      # lat, lon = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
      # params = params.merge({location: {lat: lat, lon: lon}})
      # @hospitals = SearchService.search(params, 'hospital').records.to_a

      @hospitals = Hospital.desc(:created_at).page(params[:page]).per(params[:per])
    end

    def show
      @hospital = Hospital.find(params[:id])

      @comment = @hospital.comments.desc(:created_at).first
    end
  end
end

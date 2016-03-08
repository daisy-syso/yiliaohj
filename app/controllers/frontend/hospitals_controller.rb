module Frontend
  class HospitalsController < FrontendController

    # 离我最近 最近发布 人气最高 评价最好
    def index
      @hospitals = case params[:type]
          when 'neighbour'
            location = $redis_position.get(request.remote_ip)
            
            lat, lon = if location.present?
              location.split(',')
            else
              '31.018188,121.196516'.split(',')
            end.map(&:to_f)

            Hospital.neighbour(lat, lon, '1000km').page(params[:page]).per(params[:per]).records
          when 'publish_near'
            Hospital.all.desc(:created_at).page(params[:page]).per(params[:per])
          when 'click_count'
            Hospital.all.desc(:click_count).page(params[:page]).per(params[:per])
          when 'hot_top'
            Hospital.all.desc(:hot_top).page(params[:page]).per(params[:per])
          else
            Hospital.all.desc(:created_at).page(params[:page]).per(params[:per])
          end
    end

    def show
      @hospital = Hospital.find(params[:id])
    end
  end
end

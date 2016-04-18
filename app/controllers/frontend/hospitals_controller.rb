module Frontend
  class HospitalsController < FrontendController
    def index
      @hospital_categories = HospitalCategory.where(parent_id: nil).includes(:children)

      # @city = City.all.size

      query = {}

      # 分类
      if params[:category_name]
        query[:categories] = params[:category_name]
      end

      @hospitals = Hospital.where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @hospitals = @hospitals.geo_near([longitude, latitude]).max_distance(1000).to_a
        when 'new'
          # 最近发布
          @hospitals = @hospitals.desc(:created_at)
        when 'star'
          # 评价最好
          @hospitals = @hospitals.desc(:star)
        when 'click_count'
          # 人气最高
          @hospitals = @hospitals.desc(:click_count)
        end
      end

      if params[:sort_type] == 'neighbour'
        @hospitals = Kaminari.paginate_array(@hospitals).page(params[:page]).per(params[:per])
      else
        @hospitals = @hospitals.page(params[:page]).per(params[:per])
      end
      
    end

    def show
      @hospital = Hospital.find(params[:id])

      @hospital.visit!

      @comment = @hospital.comments.desc(:created_at).first
    end
  end
end

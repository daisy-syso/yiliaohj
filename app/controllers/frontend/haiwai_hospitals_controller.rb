module Frontend
  class HaiwaiHospitalsController < FrontendController
    def index
      @hospital_categories = HospitalCategory.where(parent_id: nil).includes(:children)
      @proviences = Provience.includes(:cities)
      @hospital_levels = %w(三级特等 三级甲等 三级乙等 三级合格 二级甲等 二级乙等 二级合格 一级甲等 一级乙等 一级合格 社区医院 民营医院 外资医院)
      query = {}

      # 分类
      query[:categories] = params[:category_name] if params[:category_name]

      # 等级
      query[:level] = params[:category_level] if params[:category_level]

      query[:is_foreign] = true

      if params[:county].present?
        query[:county] = County.where(name: params[:county]).first
      end

      # 城市
      city = params[:city] || $redis_position.get("#{request.remote_ip}_city") || '上海市'
      query[:city] = City.where(name: city).first

      @hospitals = Hospital.where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'neighbour'
          # 离我最近
          latitude, longitude = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
          @hospitals = @hospitals.geo_near([longitude, latitude]).spherical.max_distance(1000).to_a
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

      # {key: [[],[]],key: [[],[]]}
      @doctors = {}
      @hospital.doctors.includes(:comments).includes(:department).each do |d|
        if @doctors.keys.include? d.department
          @doctors[d.department] << [d.id.to_s, d.name, d.position]
        else
          @doctors[d.department] = [[d.id.to_s, d.name, d.position]]
        end
      end

      @hospital.visit!

      @comment = @hospital.comments.desc(:created_at).first
    end
  end
end

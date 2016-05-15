module Frontend
  class HospitalsController < FrontendController
    # before_action :get_filters, only: [:index]

    def index
      @hospital_categories = HospitalCategory.where(parent_id: nil).includes(:children)
      @proviences = Provience.includes(:cities)
      @hospital_levels = %w(三级特等 三级甲等 三级乙等 三级合格 二级甲等 二级乙等 二级合格 一级甲等 一级乙等 一级合格 社区医院 民营医院 外资医院)
      query = {}

      query[:is_foreign] = params[:is_foreign] if params[:is_foreign].present?

      # 分类
      query[:categories] = params[:category_name] if params[:category_name]

      # 等级
      query[:level] = params[:category_level] if params[:category_level]

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

    private

    def get_filters
      @big_categories = [
        {
          key: 'hospitals',
          name: '医院大全',
          has_next: true
        },
        {
          key: 'diseases',
          name: '疾病查询',
          has_next: false
        },
        {
          key: 'doctors',
          name: '找医生',
          has_next: false
        },
        {
          key: 'symptoms',
          name: '症状查询',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '肿瘤医院',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '母婴会馆',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '月子团购',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '保险团购',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '保健品团购',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '精准攻略',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '精准体检',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '特色科室',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '最新优惠',
          has_next: false
        },
        {
          key: 'hospitals',
          name: '海外医疗',
          has_next: false
        },
        {
          key: 'buffets?hospital_category_parent_name=整形',
          name: '精准整形',
          has_next: false
        },
        {
          key: 'buffets?hospital_category_parent_name=牙科',
          name: '精准牙科',
          has_next: false
        },
        {
          key: 'buffets?hospital_category_parent_name=妇幼',
          name: '精准妇幼',
          has_next: false
        },
        {
          key: 'buffets?hospital_category_parent_name=男科',
          name: '精准男科',
          has_next: false
        },
        {
          key: 'buffets?hospital_category_parent_name=中医',
          name: '精准中医',
          has_next: false
        },
        {
          key: 'drugs',
          name: '精准购药',
          has_next: false
        }
      ]
    end
  end
end

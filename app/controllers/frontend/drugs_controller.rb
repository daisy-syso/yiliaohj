module Frontend
  class DrugsController < FrontendController
    # before_action :get_filters, only: [:index]

    def index
      @filter_filter_name = '精准药品'
      query = {}

      if params[:drug_names_disease_id].present?
        drug_names_disease_id = params[:drug_names_disease_id]
        # drug_names_disease_id = '56fcdceee8f111237421cd83'
        disease = Disease.find(drug_names_disease_id)
        drug_names = disease.drug_names
        query[:name.in] = drug_names
      end

      @drugs = Drug.where(query)

      if params[:sort_type].present?
        @drugs = case params[:sort_type]
                 when 'star'
                   # 评价最好
                   @drugs.desc(:star)
                 when 'click_count'
                   # 人气最高
                   @drugs.desc(:click_count)
                 else
                   # 最近发布
                   @drugs.desc(:created_at)
                 end
      end

      @drugs = @drugs.page(params[:page]).per(params[:per])
    end

    def show
      @drug = Drug.find(params[:id])

      @drug.visit!

      @comment = @drug.comments.desc(:created_at).first
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

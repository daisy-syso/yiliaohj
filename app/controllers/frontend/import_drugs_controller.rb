module Frontend
  class ImportDrugsController < FrontendController
    def index
      query = {}

      @import_drug_categories = ImportDrugCategory.where(parent_id: nil)
      @drugs = ImportDrug.where(query)

      if params[:sort_type].present?
        case params[:sort_type]
        when 'star'
          # 评价最好
          @drugs = @drugs.desc(:star)
        when 'click_count'
          # 人气最高
          @drugs = @drugs.desc(:click_count)
        when 'price'
          # 价格排序
          @drugs = @drugs.desc(:price)
        else
          # 最近发布
          @drugs = @drugs.desc(:created_at)
        end
      end
      @drugs = @drugs.page(params[:page]).per(params[:per])
    end

    def show
      @drug = ImportDrug.find(params[:id])

      @drug.visit!

      @comment = @drug.comments.desc(:created_at).first
    end
  end
end
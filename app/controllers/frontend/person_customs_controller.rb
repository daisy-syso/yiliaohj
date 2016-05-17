module Frontend
  class PersonCustomsController < FrontendController
    before_action :auth_check, only: [:index, :more_information, :more_questions]

    before_action :get_subscription_category_ids, only: [:index, :more_information]

    def index
      # 大分类
      @subscription_categories = SubscriptionCategory.where(parent_id: nil).includes(:children)

      # 已经关注的分类
      @subscription_category_ids = @current_user.subscriptions.map(&:subscription_category_ids).flatten
    end

    def more_information
      subscription_categories = SubscriptionCategory.where(:id.in => @subscription_category_ids)

      arr = []
      subscription_categories.each do |subscription_category|
        if subscription_category.information_ids.present?
          Information.where(:id.in => subscription_category.information_ids).each do |i|

            tmp = {
              subscription_category_name: subscription_category.name,
              information: {
                id: i.id.to_s,
                title: i.title,
                created_at: i.created_at.strftime("%F")
              }
            }

            arr << tmp
          end
        end
      end

      page = params[:page].to_i
      per = params[:per].to_i
      offset = page == 1 ? 0 : page*per

      results = arr[offset, per]

      html = ""
      results.each do |r|

        html += %Q(<li class="push-item">
          <a href="/information/#{r[:information][:id]}" class="title">【#{r[:subscription_category_name]}】#{r[:information][:title]}</a>
          <div class="publish-time">#{r[:information][:created_at]}</div>
          </li>)
      end

      render text: html
    end

    def more_questions
      questions = @current_user.questions.desc(:updated_at).page(params[:page]).per(params[:per])

      page = params[:page].to_i
      per = params[:per].to_i
      offset = page == 1 ? 0 : page*per

      html = ""
      questions.each do |question|

        html += %Q(<a href="#{frontend_question_path(question)}" >
            <li class="question-item">
              <span class="title">
                #{question.content.slice(0,20)}
              </span>
              <div class="publish-time">
                发布时间：#{question.created_at.strftime("%F %T")}
              </div>
              <div class="question-tag badge #{question.answer.present? ? 'answered-tag' : 'waiting-tag'}">
                 #{question.answer.present? ? '已答复' : '待答复'}
              </div>
            <li>
          </a>)
      end

      render text: html
    end

    private

    def get_subscription_category_ids
      @subscription_category_ids = @current_user.subscriptions.map(&:subscription_category_ids).flatten
    end
  end
end

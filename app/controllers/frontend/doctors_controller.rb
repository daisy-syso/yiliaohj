module Frontend
  class DoctorsController < FrontendController
    before_action :set_doctor_disease, only: [:like]

    # 人气最高 评价最好
    def index
      query = {}
      if params[:department_id]
        set_department
        @doctors = @department.doctors.includes(:hospital).page(params[:page]).per(10)
      else
        @doctors = Doctor.includes(:hospital).desc(:created_at).page(params[:page]).per(10)
      end

      # @doctors = case params[:type]
      #            when 'created_at'
      #              Doctor.includes(:hospital).desc(:created_at).page(params[:page]).per(params[:per])
      #            when 'click_count'
      #              Doctor.includes(:hospital).desc(:click_count).page(params[:page]).per(params[:per])
      #            else
      #              Doctor.includes(:hospital).desc(:created_at).page(params[:page]).per(params[:per])
      #             end
    end

    def show
      @doctor = Doctor.find(params[:id])

      @comment = @doctor.comments.desc(:created_at).first

      @diseases = @doctor.diseases
    end

    def like
      current_user = User.where(id: session[:user_id]).first

      if current_user.present?
        @doctor_disease.change_like!(current_user)
        render json: { msg: 'ok', status: 200 }
      else
        render json: { msg: '请登录', status: 422 }
      end
    end

    private

    def set_department
      @department = Department.find(params[:department_id])
    end

    def set_doctor_disease
      @doctor_disease = DoctorDisease.where(doctor_id: params[:doctor_id], disease_id: params[:disease_id]).first
    end
  end
end

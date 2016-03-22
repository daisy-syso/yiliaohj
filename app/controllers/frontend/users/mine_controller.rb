module Frontend
  module Users
    class MineController < FrontendController
      def finish_user_info_for_email_register
        @user = User.new
      end
    end
  end
end

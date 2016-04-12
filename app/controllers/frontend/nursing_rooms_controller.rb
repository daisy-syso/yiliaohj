module Frontend
  class NursingRoomsController < FrontendController
    def index
      @nursing_rooms = NursingRoom.all.page(params[:page]).per(10)
    end

    def show
      @nursing_room = NursingRoom.includes(:comments).find(params[:id])
      @comments = @nursing_room.comments.desc(:created_at).first
    end
  end
end

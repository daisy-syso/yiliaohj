module Frontend
  class NursingRoomsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      @nursing_room = NursingRoom.all.page(params[:page]).per(params[:per])
    end

    def show
      @nursing_rooms = NursingRoom.find(params[:id])
    end
  end
end

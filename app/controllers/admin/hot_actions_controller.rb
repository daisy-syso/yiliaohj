# class Admin::HotActionsController < AdminController
#   before_action :check_auth
#   before_action :set_hot_action, only: [:show, :edit, :update, :destroy]

#   def index
#     @hot_actions = HotAction.all.desc(:created_at).page(params[:page]).per(params[:per])
#     respond_to do |format|
#       format.html
#     end
#   end

#   def show
#     respond_to do |format|
#       format.html
#     end
#   end

#   def new
#     @hot_action = HotAction.new
#   end

#   def create
#     @hot_action = HotAction.new(hot_action_params)

#     respond_to do |format|
#       if @hot_action.save
#         format.html { redirect_to admin_hot_actions_url, notice: 'hot_action was successfully created.' }
#       else
#         format.html { render action: :new }
#       end
#     end
#   end

#   def destroy
#     @hot_action.destroy
#     respond_to do |format|
#       format.html { redirect_to admin_hot_actions_url }
#     end
#   end

#   def edit
#   end

#   def update
#     @hot_action.update_attributes(hot_action_params)

#     if @hot_action.valid?
#       render action: :show
#     else
#       render action: :edit
#     end
#   end

#   private

#   def set_hot_action
#     @hot_action = HotAction.find(params[:id])
#   end

#   def hot_action_params
#     params.require(:hot_action).permit(:title, :link, :image_url)
#   end
# end

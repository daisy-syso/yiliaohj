# module Admin
# class BannersController < AdminController
#   before_action :check_auth
#   before_action :set_banner, only: [:show, :edit, :update, :destroy]

#   def index
#     @banners = Banner.all.desc(:created_at).page(params[:page]).per(params[:per])

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
#     @banner = Banner.new
#   end

#   def create
#     @banner = Banner.new(banner_params)

#     respond_to do |format|
#       if @banner.save
#         format.html { redirect_to admin_banners_url, notice: 'Banner was successfully created.' }
#       else
#         format.html { render action: 'new' }
#       end
#     end
#   end

#   def destroy
#     @banner.destroy
#     respond_to do |format|
#       format.html { redirect_to admin_banners_url }
#     end
#   end

#   private
#     def set_banner
#       @banner = Banner.find(params[:id])
#     end

#     def banner_params
#       params.require(:banner).permit(:title, :link, :image_url)
#     end
# end
# end
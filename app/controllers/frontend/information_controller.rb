class Frontend::InformationController < FrontendController
  before_action :set_information, only: [:show]

  def index
  end

  def show
  end

  private

  def set_information
    @information = Information.find(params[:id])
  end
end

class AdminsController < ApplicationController

  before_action  :admin, only: [:index]
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    @default = Default.new
  end

  def default
    if params[:default][:icon_image].present?
       params[:default][:icon_type]  = params[:default][:icon_image].content_type.chomp
       params[:default][:icon]       = params[:default][:icon_image].read
    end
    if params[:default][:logo_image].present?
       params[:default][:logo_type]  = params[:default][:logo_image].content_type.chomp
       params[:default][:logo]       = params[:default][:logo_image].read
    end
    if params[:default][:default_dp_image].present?
       params[:default][:default_dp_type]  = params[:default][:default_dp_image].content_type.chomp
       params[:default][:default_db]       = params[:default][:default_dp_image].read
    end
    @default  = Default.find_by_id(1)  
    if @default.present?
      if @default.update(default_params)
        render text: 'updated'
      else
        render text: 'update error'
      end
    else
      @def = Default.new(default_params)
      if @def.save
        render text: 'saved'
      else
        render text: 'save error'
      end
    end
  end


private

def default_params
  params.require(:default).permit(:icon,:logo,:default_db,:icon_type,:logo_type,:default_dp_type)
end

end

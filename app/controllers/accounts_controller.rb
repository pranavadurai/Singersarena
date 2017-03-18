class AccountsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:user][:image].present?
       params[:user][:pictype]  = params[:user][:image].content_type.chomp
       params[:user][:pic]      = params[:user][:image].read
       params[:user][:dpic]     = nil
    else
       params[:user][:dpic]     = "/assets/profile.png"
    end
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        params[:user][:user_id] = @user.id
        @authe = Authentication.new(authsignup_params)
        if @authe.save
          sign_in @authe
          UserMailer.welcome_email(@user).deliver_later
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def signin
  end

  def login
    user = Authentication.find_by_email(params[:login][:email])
    if user.password == params[:login][:password]
      sign_in user
      redirect_to root_path
    else
      render text: '<div class="alert alert-success Text-center" role="alert">Email Or Password Wrong</div>'.html_safe
    end
  end

  def forget_password
    if params[:profile].present?
        @user = Authentication.find_by_email(params[:profile][:email])
        @user.forgetkey = SecureRandom.urlsafe_base64
        if @user.update(authen_params)
          UserMailer.password_reset(@user).deliver_later
          render text: '<div class="alert alert-success text-center" role="alert">Check your mail for the reset link!!!</div>'.html_safe
        else
          render text: 'Something Went Wrong Please try again'
        end
    end
  end

  def password_reset

  end

  def signout
    sign_out
    redirect_to root_path
  end

  def check_email
    @profile = Authentication.find_by_email(params[:email])
    if !@profile
      render text: 'new'
    else
      render text: '<div class="alert alert-danger Text-center" role="alert">Email is Already Registered With US!</div>'.html_safe
    end
  end

  def email_check
    @profile = Authentication.find_by_email(params[:email])
    if @profile
      render text: 'new'
    else
      render text: '<div class="alert alert-danger Text-center" role="alert">Email is Not Registered With US!</div>'.html_safe
    end
  end

  def logo
    logo = Default.find_by_id(1)
    send_data(logo.logo,:type => "image/png",:disposition => "inline")
  end

  def icon
    icon = Default.find_by_id(1)
    send_data(icon.icon,:type => "image/png",:disposition => "inline")
  end

  def default_dp
    logo = Default.find_by_id(1)
    send_data(logo.default_db,:type => "image/png",:disposition => "inline")
  end



  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def authen_params
      params.require(:profile).permit(:forgetkey)
    end

    def authsignup_params
      params.require(:user).permit(:email,:password,:user_id)
    end

end

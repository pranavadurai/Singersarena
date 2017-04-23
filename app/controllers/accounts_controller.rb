class AccountsController < ApplicationController

  before_action :check_key, only: [:password_reset]

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
          format.html { redirect_to @user, :flash => {:success =>'Profile was successfully created.' }}
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
    if user && user.authenticate(params[:login][:password])
      sign_in user
      redirect_to root_path
    else
      respond_to do |format|
        format.html { redirect_to signin_path, :flash => {:danger =>'Password Wrong try again..' }}
        format.json { }
      end
    end
  end

  def forget_password
    if params[:profile].present?
        @authe = Authentication.find_by_email(params[:profile][:email])
        params[:profile][:forgetkey]= SecureRandom.urlsafe_base64
        if @authe.update(authen_params)
          UserMailer.password_reset(@authe).deliver_now
          render :json => '{"key":"success","msg":"Link has been mailed.please check your Mail."}'
        else
          render :json => '{"key":"danger","msg":"Something went wrong try again!!!."}'
        end
    end
  end

  def password_reset

  end

  def password_change
    respond_to do |format|
      if params[:profile][:password] == params[:profile][:again_password]
        if params[:profile][:f_key].present?
            if @user = Authentication.find_by_forgetkey(params[:profile][:f_key])
               @user.update(password_reset_params)
                UserMailer.password_reset_success(@user).deliver_now
                  format.html { redirect_to signin_url,:flash => {:success => 'password successfully Reseted login now.' }}
                  format.json { }
            else
              format.html { redirect_to forget_password_accounts_path,:flash => {:danger => 'Something went wrong please try again.' }}
              format.json { }
            end
        else
          if @user = Authentication.find_by_user_id(current_user.id)
            @user.update(password_reset_params)
             UserMailer.password_reset_success(@user).deliver_now
               format.html { redirect_to signin_url,:flash => {:success => 'password successfully Reseted login now.' }}
               format.json { }
         else
           format.html { redirect_to forget_password_accounts_path, :flash => {:danger => 'Something went wrong please try again.' }}
           format.json { }
         end
       end
      else
        format.html { redirect_to forget_password_accounts_path, :flash => {:danger =>'Password Missmatch..' } }
        format.json { }
      end
    end
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
      render text: '<div class="alert alert-danger text-center" role="alert">Email is Already Registered With US!</div>'.html_safe
    end
  end

  def email_check
    @profile = Authentication.find_by_email(params[:email])
    if @profile
      render text: 'new'
    else
      render text: '<div class="alert alert-danger text-center" role="alert">Email is Not Registered With US!</div>'.html_safe
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
      params.require(:profile).permit(:forgetkey,:email)
    end

    def authsignup_params
      params.require(:user).permit(:email,:password,:user_id)
    end

    def password_reset_params
      params.require(:profile).permit(:password)
    end

    def check_key
    if params[:f_key].present?
      @user = Authentication.find_by_forgetkey(params[:f_key])
      if !@user.present?
        flash[:danger] = 'Somethig went wrong try again'
        redirect_to forget_password_accounts_path
      end
    else
      signed_in_user
    end

  end

end

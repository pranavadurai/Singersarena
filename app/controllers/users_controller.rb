class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user, only: [:index,:show,:edit,:update,:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
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

  def image_display
    user = User.find(params[:id])
    send_data(user.pic,:type=>user.pictype, :disposition => 'inline' )
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:image].present?
       params[:user][:pictype]  = params[:user][:image].content_type.chomp
       params[:user][:pic]      = params[:user][:image].read
       params[:user][:dpic]     = nil
    else
       params[:user][:dpic]     = "/assets/profile.png"
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "#{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def signout
    sign_out
    redirect_to root_path
  end

  def check_email
    @profile = User.find_by_email(params[:email])
    if !@profile
      render text: 'new'
    else
      render text: '<div class="alert alert-danger Text-center" role="alert">Email is Already Registered With US!</div>'.html_safe
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email,:name,:phone,:gender,:city,:country,:pic,:pictype,:dpic,:aboutme)
    end

    def authsignup_params
      params.require(:user).permit(:email,:password,:user_id)
    end
end

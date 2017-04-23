class UserMailer < ApplicationMailer
  default from: 'Singersarena'

  def welcome_email(user)
    @user = user
    @url  = 'http ://singersarena.herokuapp.com/signin'
    mail(to: @user.email,subject: 'Welcome to singersarena')
  end

  def password_reset(user)
    @user = user
    @url  = "http://singersarena.herokuapp.com/accounts/password_reset?f_key=#{@user.forgetkey}"
    mail(to: @user.email,subject: 'Password Reset')
  end

  def password_reset_success(user)
    @user = user
    @url = "http://singersarena.herokuapp.com/signin"
    @url1 = "http://singersarena.herokuapp.com/forget_password_accounts_path"
    mail(to: @user.email,subject: 'Password Reset successfully')
  end

end

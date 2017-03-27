class UserMailer < ApplicationMailer
  default from: 'Singersarena'

  def welcome_email(user)
    @user = user
    @url  = 'https://singersarena.herokuapp.com/signin'
    mail(to: @user.email,subject: 'Welcome to singersarena')
  end

  def password_reset(user)
    @user = user
    @url  = "http://localhost:3000/accounts/password_reset?f_key=#{@user.forgetkey}"
    mail(to: @user.email,subject: 'Password Reset')
  end

  def password_reset_success(user)
    @user = user
    @url = "http://localhost:3000/signin"
    @url1 = "http://localhost:3000/forget_password_accounts_path"
    mail(to: @user.email,subject: 'Password Reset successfully')
  end

end

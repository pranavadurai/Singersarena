class UserMailer < ApplicationMailer
  default from: 'Singersarena'

  def welcome_email(user)
    @user = user
    @url  = 'https://singersarena.herokuapp.com/signin'
    mail(to: @user.email,subject: 'Welcome to singersarena')
  end

  def password_reset(user)
    @user = user
    @url  = "https://singersarena.herokuapp.com/password_reset?f_key=#{@user.forgetkey}"
    mail(to: @user.email,subject: 'Password Reset')
  end

end

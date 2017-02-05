class UserMailer < ApplicationMailer
  default from: 'Singersarena'

  def welcome_email(user)
    @user = user
    @url  = 'https://singersarena.herokuapp.com/signin'
    mail(to: @user.email,subject: 'Welcome to singersarena')
  end
end

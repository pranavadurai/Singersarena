class UserMailer < ApplicationMailer
  default from: 'Singersarena'

  def welcome_email(user)
    @user = user
    @url  = 'http://singersarena.heroku.com/login' 
end

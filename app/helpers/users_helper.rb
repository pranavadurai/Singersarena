module UsersHelper

  def sign_in(authenti)
    cookies.permanent[:remember_token]=authenti.remember_token
    self.current_user= authenti
  end

  def current_user=(user)
    @current_user=current_user
  end

  def current_user
    user=Authentication.find_by_remember_token(cookies[:remember_token])
    if(!user.nil?)
      @current_user ||= User.find(user.user_id)
    end
  end

  def current_user?(user)
    user==current_user
  end

end

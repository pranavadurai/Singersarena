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

  def signedin?
    !current_user.nil?
  end

  def sign_out
    self.current_user=nil
    cookies.delete(:remember_token)
  end

  def signed_in_user
    unless signedin?
      redirect_to root_path
    end
  end

  def user_image(user_id)
    user = User.find(user_id)
    if user.dpic.nil?
      url_for( :action => "image_display",:id => user.id, :controller=> "users" )
    else
      user.dpic
    end
  end

end

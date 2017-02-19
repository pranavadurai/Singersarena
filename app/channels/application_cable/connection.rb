module ApplicationCable
  class Connection < ActionCable::Connection::Base
     identified_by :auth_user

     def connect
       self.auth_user = find_verified_user
     end

     private
     def find_verified_user
       user = Authentication.find_by_remember_token(cookies[:remember_token])
       if (!user.nil?)
         auth_user = User.find(user.user_id)
         auth_user
       else
         reject_unauthorized_connection
       end
     end

   end
  end

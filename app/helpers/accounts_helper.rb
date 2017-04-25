module AccountsHelper

  def logo
    id =1
    default = Default.find_by_id(1)
    if default.present?
       url_for( :action => "logo",:id => id, :controller=> "accounts" )
    end
  end

  def icon
    id =1
    default = Default.find_by_id(1)
    if default.present?
       url_for( :action => "icon",:id => id, :controller=> "accounts" )
    end
  end
  
end

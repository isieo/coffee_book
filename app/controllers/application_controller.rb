class ApplicationController < ActionController::Base
  #before_filter :authenticate_user!
  before_filter :check_user_address, :except => [:update, :edit]
  before_filter :check_user_login_count
  
  protect_from_forgery
  
  def check_user_address
    if user_signed_in?
      if current_user.address.blank?
        flash[:notice] = "We need your address to find jobs near you!"
        redirect_to "/users/edit"
      end
    end
  end
  
  def check_user_login_count
    if !current_user.nil?
      if !current_user.address.blank?
        if current_user.sign_in_count == 1
          redirect_to guide_path
          current_user.sign_in_count = 2
          current_user.save
        end
      end
    end
  end
  

end



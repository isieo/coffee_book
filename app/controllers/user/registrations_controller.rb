class User::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => :token

  def new
    super
  end

  
  def create
    build_resource
    if resource.save
      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        expire_session_data_after_sign_in!
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => root_path
      end
    else
      clean_up_passwords resource
      render :template => "home/show"
    end
  end

  def update
    super
  end
  
  protected
  def after_sign_up_path_for(resource)
    edit_user_registration_path(current_user)
  end
  
  def after_update_path_for(resource)
    user_accounts_path(current_user)
  end
end

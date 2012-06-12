class User::SessionsController < Devise::SessionsController
  def new
    render "home/show"
  end
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    sign_in(resource_name, resource)
    redirect_to user_accounts_path(current_user)
  end
  
  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(current_user)
    redirect_to root_path
  end
end

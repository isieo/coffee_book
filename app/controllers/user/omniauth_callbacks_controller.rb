class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :load_mock
  def passthru
    session[:return_to] = params[:redirect_uri]
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:notice] = "facebook login error"
      redirect_to root_path
    end
  end
  
  def load_mock
    return if !Rails.env.test?
    request.env["devise.mapping"] = Devise.mappings[:user] 
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
  end
end

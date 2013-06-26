class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :load_mock
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      flash[:alert] = user.errors.full_messages.to_sentence
      redirect_to new_user_registration_url
    end
  end
  alias_method :facebook, :all
  
  def load_mock
    return if !Rails.env.test?
    request.env["devise.mapping"] = Devise.mappings[:user] 
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
  end
end

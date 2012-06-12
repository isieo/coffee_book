class User::AccountsController < ApplicationController
  before_filter :find_user, :only => [:index, :edit, :update]
  def index
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].blank?
      # Bypass to enter current password and password is null during update profile
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      params[:user].delete(:current_password)
    else
      # Bypass to enter current password during update profile
      params[:user].delete(:current_password)
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "User profile updated successfully."
      redirect_to user_accounts_url(@user)
    else
      render :action => :edit
    end
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
end

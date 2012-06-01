class User::AccountsController < ApplicationController
  before_filter :find_user, :only => [:index, :edit, :update]
  def index
  end
  
  def edit
  end
  
  def update
    if @user.update(params[:user])
      flash[:notice] = "User profile updated successfully."
      redirect_to user_accounts_url
    else
      render :action => :edit
    end
  end
  
  protected
  def find_user
    @user = current_user
  end
end

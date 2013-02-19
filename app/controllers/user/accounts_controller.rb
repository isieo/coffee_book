class User::AccountsController < ApplicationController
  before_filter :find_user, :only => [:index, :edit, :update]
  def index
    @reviews = @user.reviews.page(params[:page]).per(3)
  end
  
  def edit
    @user = User.search(params[:username]).all.first
    @coordinates_longitude = @user.coordinates_longitude
    @coordinates_latitude = @user.coordinates_latitude
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
      sign_in @user, :bypass => true
      flash[:notice] = "User profile updated successfully."
      redirect_to user_accounts_url(@user)
    else
      render :action => :edit
    end
  end
  
  def map
    if !current_user.address.nil?
      @lon = current_user.coordinates_longitude
      @lat = current_user.coordinates_latitude
    elsif request.location.longitude > 0
      @lon = request.location.longitude
      @lat = request.location.latitude
    else
      @lon = 101.989
      @lat = 3.129
    end
    @jobs = Job.near([@lat,@lon],20)
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
end

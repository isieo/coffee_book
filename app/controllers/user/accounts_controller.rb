class User::AccountsController < ApplicationController
  before_filter :find_user, :only => [:index, :edit, :update]
  def index
    @reviews = @user.reviews.page(params[:page]).per(3) if !@user.nil?
  end

  def edit
    @user = User.search(params[:username]).all.first
    if @user.address.blank?
      if Rails.env == "development"
        geo_data = Geocoder.search("118.107.243.154")
      else
        geo_data = Geocoder.search(request.ip)
      end
      
      if !geo_data.blank?
        geo_data = geo_data.first
      else
        raise "no geo data found"
      end
      @coordinates_longitude = geo_data.data['longitude']
      @coordinates_latitude = geo_data.data['latitude']
    else
      @coordinates_longitude = @user.coordinates_longitude
      @coordinates_latitude = @user.coordinates_latitude
    end
  end
  
  def update
    #if params[:user][:password].blank?
      # Bypass to enter current password and password is null during update profile
      #params[:user].delete(:password)
      #params[:user].delete(:password_confirmation)
      #params[:user].delete(:current_password)
    #else
      # Bypass to enter current password during update profile
      #params[:user].delete(:current_password)
    #end
  #:name,  :email, :address,
  #:coordinates_latitude,:coordinates_longitude ,:city, 
  #:state, :country, :contact_mobile, :contact_home, :dob, 
  #:gender, :nationality, :ic_number, :cover_image
    if @user == current_user
      @user.email = params[:user][:email]
      @user.name = params[:user][:name]
      @user.address = params[:user][:address]
      @user.coordinates_latitude = params[:user][:coordinates_latitude]
      @user.coordinates_longitude = params[:user][:coordinates_longitude]
      @user.contact_mobile = params[:user][:contact_mobile]
      @user.contact_home = params[:user][:contact_home]
      if !params[:user]['dob(3i)'].blank? && !params[:user]['dob(2i)'].blank? && !params[:user]['dob(1i)'].blank?
        dob = params[:user]['dob(3i)'] + "-" + params[:user]['dob(2i)'] + "-" + params[:user]['dob(1i)']
        @user.dob = dob
      end
      @user.gender = params[:user][:gender]
      @user.nationality = params[:user][:nationality]
      @user.ic_number = params[:user][:ic_number]
      @user.cover_image = params[:user][:cover_image] if params[:user][:cover_image]
      @user.cover_image_uid_will_change!
      @user.save
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
  
  def application
    @pending = current_user.job_applications.where(:status => 'pending')
    @approved = current_user.jobs
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
end

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
  
  def update_not_used
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
    @jobs = Job.all
    @marker_array = []
    if !params[:lon].nil?
      @lon = params[:lon]
      @lat = params[:lat]
    elsif request.location.longitude > 0
      @lon = request.location.longitude
      @lat = request.location.latitude
    else
      @lon = 101.989
      @lat = 3.129
    end

    if !current_user.nil?
      if !current_user.coordinates_longitude.blank?
        @address_lon = current_user.coordinates_longitude
        @address_lat = current_user.coordinates_latitude
        for job in Job.near([@address_lat, @address_lon],20)
          @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.pay),job.pay_per,job.date]
        end
        
      end
    end
    for job in Job.near([@lat,@lon],20)
      @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.pay),job.pay_per,job.date]
    end
    respond_to do |format|
      format.html {}
      format.js {render json: @marker_array}
    end
  end
  
  def application
    @pending = current_user.job_applications.where(:status => 'pending')
    @rejected = current_user.job_applications.where(:status => 'rejected')
    @approved = current_user.jobs
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
end

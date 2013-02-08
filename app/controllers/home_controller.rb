class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
    @jobs = Job.all
    @marker_array = []
    i = 2
    if !current_user.nil?
      if !current_user.address.nil?
        @lon = current_user.coordinates_longitude
        @lat = current_user.coordinates_latitude
        @user = current_user
        for job in Job.near(@user.address)
          @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.salary),job.date]
          i = i + 1
        end
      end
    else
      @lon = params[:lon] || (request.location.longitude > 0 ? request.location.longitude : 101.989)
      @lat = params[:lat] || (request.location.latitude > 0 ? request.location.latitude : 3.129)

      @jobs = Job.near([@lat,@lon],20).each do |job|
        if !job.coordinates_longitude.nil? && !job.coordinates_latitude.nil?
          @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.salary),job.date] 
        end
        i = i + 1
      end

    end
    
    respond_to do |format|
      format.html {}
      format.js {render json: @marker_array}
    end
  end
end

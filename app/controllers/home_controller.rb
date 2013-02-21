class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
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
        @lon = current_user.coordinates_longitude
        @lat = current_user.coordinates_latitude
      end
    end
    i = 2
    for job in Job.near([@lat,@lon],20)
      @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.salary),job.date]
      i = i + 1
    end
    
    respond_to do |format|
      format.html {}
      format.js {render json: @marker_array}
    end
  end
end

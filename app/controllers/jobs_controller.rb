class JobsController < ApplicationController
before_filter :find_job, :only => [:show, :apply]
  def index
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

  def show
    @reviews = @job.company.reviews.all.page(params[:page]).per(3)
  end
  
  protected
  def find_job
    @job = Job.find(params[:id])
  end
end

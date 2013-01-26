class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
    @jobs = Job.all
    @marker_array = []
    i = 2
    if !current_user.nil?
      if !current_user.address.nil?
        @user = current_user
        for job in Job.near(@user.address)
          @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.salary),job.date]
          i = i + 1
        end
      end
    else
      if Rails.env == "development"
        @user = User.create(:address => "Klang", :coordinates_latitude => "3.090607", :coordinates_longitude => "101.529597")
      else
        @user = User.create(:address => request.location.city, :coordinates_latitude => request.location.latitude, :coordinates_longitude => request.location.longitude)
      end
      for job in Job.near(@user.address)
        @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.salary),job.date]
        i = i + 1
      end
    end
  end
  
end

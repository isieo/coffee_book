class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
    @jobs = Job.all
    
    @marker_array = []
    i = 2
    if current_user != nil
      if current_user.address != nil
        for job in Job.near(current_user.address)
          @marker_array << [job.id, job.coordinates_latitude, job.coordinates_longitude, (self.class.helpers.link_to job.title, job_url(job)),('%.2f' % job.salary),job.date]
          i = i + 1
        end
      end
    end
  end
end

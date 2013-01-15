class JobsController < ApplicationController
before_filter :find_job, :only => [:show, :apply]
  def index
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

  def show
    
  end
  
  def apply
    @job.applicant << [current_user.username,Time.now]
    @job.save
    @job.company.admins.each do |admin|
      Delayed::Job.enqueue NotifyJob.new(admin.id, current_user.id, @job.id)
    end
    @job.company.members.each do |member|
      Delayed::Job.enqueue NotifyJob.new(member.id, current_user.id, @job.id)
    end
    flash[:notice] = "Job applied successfully, please wait for approval or contact"
    redirect_to jobs_path
  end
  
  protected
  def find_job
    @job = Job.find(params[:id])
  end
end

class JobsController < ApplicationController
before_filter :find_job, :only => [:show, :apply]
  def index
    if params[:job].present?
      @jobs = Job.search(params[:job])
    else
      @jobs = Job.all
    end
  end

  def show
    
  end
  
  def apply
    @job.applicant << [current_user.username,Time.now]
    @job.save
    flash[:notice] = "Job applied successfully, please wait for approval or contact"
    redirect_to jobs_path
  end
  
  protected
  def find_job
    @job = Job.find(params[:id])
  end
end

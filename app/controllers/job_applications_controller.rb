class JobApplicationsController < ApplicationController
  before_filter :initialize_job
  
  def show
    @application = JobApplication.find(params[:job_id])
  end
  
  def new
    @job = Job.find(params[:job_id])
    @application = @job.job_applications.new
  end
  
  def create
    @job = Job.find(params[:job_id])
    @application = @job.job_applications.new
    @application.applicant_description = params[:job_application][:applicant_description]
    @application.user_id = current_user.id
    @application.username = current_user.username
    @application.company_id = @job.company.id
    @application.save
    @application.company.admins.each do |admin|
      Delayed::Job.enqueue NotifyJob.new(admin.id, current_user.id, @job.id)
    end
    flash[:notice] = "Job applied successfully, please wait for approval or contact"
    redirect_to application_path
  end
  
  private
  def initialize_job
  end
end

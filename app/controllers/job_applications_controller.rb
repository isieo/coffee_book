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
    UserMailer.job_application_notification(@application).deliver
    redirect_to application_path
  end
  
  def edit
    @application = JobApplication.find(params[:job_id])
  end
  
  def update
    application = JobApplication.find(params[:job_id])
    if params[:job_application][:status] == "rejected"
      application.status = "rejected"
      application.reject_reason = params[:job_application][:reject_reason]
      application.save
      flash[:notice] = "Job application rejected successfully"
      UserMailer.job_rejected_notification(application).deliver
      redirect_to user_account_company_path(current_user, application.company)
    elsif params[:job_application][:status] == "approved"
      application.status = "approved"
      user = application.user
      company = application.company
      user.member_of << company
      company.members << user
      user.jobs << application.job
      user.save
      company.save
      application.save
      flash[:notice] = "job_approved_notification"
      UserMailer.job_application_notification(application).deliver
      redirect_to user_account_company_path(current_user, application.company)
    end

  end
  
  def approve
    applicant = @job.job_applications.find(params[:applicant_id])
    applicant.update_attributes(:status => "approved")
    u = User.find(applicant.user_id)
    u.jobs << @job
    u.save
    @job.save

    flash[:notice] = "User approved"
    redirect_to user_account_company_job_path(@user, @company, @job)
  end


  private
  def initialize_job
  end
end

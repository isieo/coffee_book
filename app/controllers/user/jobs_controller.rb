class User::JobsController < ApplicationController
  before_filter :find_user, :find_company
  before_filter :find_job_posted, :only => [:show, :edit, :update, :destroy]
   def index
     @jobs = @company.jobs
   end
   
   def new
     @job = @company.jobs.new
   end
   
   def create
     @job = @company.jobs.new(params[:job])
     if @job.save
       flash[:notice] = "Job created successfully."
       redirect_to user_account_company_job_url(@user, @company, @job)
     else
       render :action => :new
     end
   end
   
   def show
   end
   
   def edit
   end
   
   def update
     if @job.update_attributes(params[:job])
       flash[:notice] = "Job updated successfully."
       redirect_to user_account_company_job_url(@user, @company, @job)
     else
       render :action => :edit
     end
   end
   
   def destroy
     if @job.destroy
       flash[:notice] = "Job deleted successfullly."
       redirect_to user_account_company_jobs_url(@user, @company)
     end
   end
   
   protected
   def find_user
     @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
   end
   
   def find_company
     @company = Company.where(_id: params[:company_id]).first
   end
   
   def find_job_posted
     @job = Job.where(_id: params[:id]).first
   end
end

class User::JobsController < ApplicationController
  before_filter :find_user, :find_company
  before_filter :find_job_posted, :only => [:show, :edit, :update, :destroy, :approve]
   def index
     @jobs = @company.jobs
   end
   
   def new
    @job = @company.jobs.new

    geo_data = Geocoder.search("118.107.243.154")
    if !geo_data.blank?
      geo_data = geo_data.first
    else
      raise "no geo data found"
    end
    @job.city = geo_data.city
    @job.state = geo_data.data['region_name']
    @job.country = geo_data.data['country_name']
    @coordinates_longitude = geo_data.data['longitude']
    @coordinates_latitude = geo_data.data['latitude']
   end
   
   def create
     @job = @company.jobs.new(params[:job].merge({:company_name => @company.name, :address_street1 => @company.address_street1, :address_street2 => @company.address_street2, :post_code => @company.post_code, :state => @company.state, :country => @company.country, :contact_mobile => @company.contact_mobile, :contact_office => @company.contact_office}))
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
    @job = Job.find(params[:id])
    @coordinates_longitude = @job.coordinates_longitude
    @coordinates_latitude = @job.coordinates_latitude
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
       flash[:notice] = "Job deleted successfully."
       redirect_to user_account_company_jobs_url(@user, @company)
     end
   end
   
   def approve
    array_location = 0
    @job.applicant.each do |ja|
      if ja[0] == params[:applicant]
        u = User.where(:username => params[:applicant]).first
        u.jobs << @job
        u.save
        @job.applicant.delete_at(array_location)
        @job.save
      end
      array_location += 1
    end

    flash[:notice] = "User approved"
    redirect_to user_account_company_job_path(@user, @company, @job)
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

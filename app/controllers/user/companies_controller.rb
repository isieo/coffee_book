class User::CompaniesController < ApplicationController
  before_filter :find_user
  before_filter :find_company, :only => [:edit, :update, :destroy]
  
  def index
    @companies = @user.companies
  end
  
  def new
    @company = @user.companies.new
  end
  
  def create
    @company = @user.companies.new(params[:company])
    if @company.save
      flash[:notice] = "Company created successfully."
      redirect_to user_account_companies_url
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    if @company.update_attributes(params[:company])
      flash[:notice] = "Company updated successfully."
      redirect_to user_account_companies_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    if @company.destroy
      flash[:notice] = "Company destroyed successfully."
      redirect_to user_account_companies_url
    end
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
  
  def find_company
    @company = @user.companies.where(_id: params[:id]).first
  end
end

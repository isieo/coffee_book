class User::CompaniesController < ApplicationController
  before_filter :find_user
  before_filter :find_company, :only => [:show, :edit, :update, :destroy, :new_member, :create_member, :delete_member]
  before_filter :find_member, :only => [:create_member, :delete_member]
  
  def index
    @companies = []
    @user.admin_of.collect {|a| @companies.push(a)}
    @user.member_of.collect {|m| @companies.push(m)}
  end
  
  def new
    @company = @user.admin_of.new
  end
  
  def create
    @company = @user.admin_of.new(params[:company])
    if @company.save
      @user.admin_of << @company # Assign company id into user table as admin_of_ids
      @company.admins << @user # Assign user id into company table as admin_ids
      flash[:notice] = "Company created successfully."
      redirect_to user_account_companies_url
    else
      render :action => :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @company.update_attributes(params[:company])
      flash[:notice] = "Company updated successfully."
      redirect_to user_account_companies_url(@user)
    else
      render :action => :edit
    end
  end
  
  def destroy
    if @company.destroy
      flash[:notice] = "Company destroyed successfully."
      redirect_to user_account_companies_url(@user)
    end
  end
  
  def new_member
  end
  
  def create_member
    @company.members << @member
    @member.member_of << @company
    redirect_to user_account_company_url(@user, @company)
  end
  
  def delete_member
    @member.member_of_ids.delete(@company._id)
    @member.save
    @company.member_ids.delete(@member._id)
    @company.save
    redirect_to user_account_company_url(@user, @company)
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
  
  def find_company
    @company = @user.admin_of.where(_id: params[:id]).first || @user.member_of.where(_id: params[:id]).first
  end
  
  def find_member
    if params[:company].present?
      @member = User.where(username: params[:company][:group_user]).first
    else
      @member = User.where(username: params[:member]).first
    end
  end
end

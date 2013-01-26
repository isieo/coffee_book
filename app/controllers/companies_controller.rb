class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
    @reviews = @company.reviews.all.page(params[:page]).per(3)
  end
  
end

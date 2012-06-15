class ReviewsController < ApplicationController
  def create
    if params[:company_id].present?
      company = Company.find(params[:company_id])
      review = company.reviews.new({:comment => params[:comment], :post_by => params[:username]})
      review.save
      flash[:notice] = "Review created successfully."
      redirect_to job_url(params[:job_id])
    else
      user = User.find(params[:user_id])
      review = user.reviews.new({:comment => params[:comment], :post_by => params[:username]})
      review.save
      flash[:notice] = "Review created successfully."
      redirect_to user_accounts_url(user)
    end
  end
end

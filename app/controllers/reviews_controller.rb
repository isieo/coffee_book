class ReviewsController < ApplicationController
  def create
    if params[:company_id].present?
      company = Company.find(params[:company_id])
      review = company.reviews.new({:comment => params[:comment], :poster => current_user, :rating => params[:rating]})
      review.save
      #flash[:notice] = "Review created successfully."
      redirect_to company_url(params[:company_id])
    else
      user = User.find(params[:user_id])
      review = user.reviews.new({:comment => params[:comment], :poster => current_user, :rating => params[:rating]})
      review.save
      #flash[:notice] = "Review created successfully."
      redirect_to user_accounts_url(user)
    end
  end
end

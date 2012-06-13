class User::ReviewsController < ApplicationController
  before_filter :find_user
  before_filter :find_review, :only => [:destroy]
  
  def index
    @reviews = @user.reviews
  end
  
  def new
    @review = @user.reviews.new
  end
  
  def create
    @review = @user.reviews.new(params[:review].merge({:post_by => @user.username}))
    if @review.save
      flash[:notice] = "Review created successfully."
      redirect_to user_account_reviews_url
    else
      render :action => :new
    end
  end
  
  def destroy
    if @review.destroy
      flash[:notice] = "Review destroyed successfully."
      redirect_to user_account_reviews_url
    end
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
  
  def find_achievement
    @review = @user.reviews.where(_id: params[:id]).first
  end
end

class User::AchievementsController < ApplicationController
  before_filter :find_user
  before_filter :find_achievement, :only => [:edit, :update, :destroy]
  
  def index
    @achievements = @user.achievements
  end
  
  def new
    @achievement = @user.achievements.new
  end
  
  def create
    @achievement = @user.achievements.new(params[:achievement])
    if @achievement.save
      flash[:notice] = "Achievement created successfully."
      redirect_to user_account_achievements_url
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    if @achievement.update_attributes(params[:achievement])
      flash[:notice] = "Archievement updated successfully."
      redirect_to user_account_achievements_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    if @achievement.destroy
      flash[:notice] = "Archievement destroyed successfully."
      redirect_to user_account_achievements_url
    end
  end
  
  protected
  def find_user
    @user = User.where(_id: params[:id]).first || User.where(username: params[:username]).first
  end
  
  def find_achievement
    @achievement = @user.achievements.where(_id: params[:id]).first
  end
end

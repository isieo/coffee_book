class UsersController < ApplicationController
  def index
    if params[:user].present?
      @users = User.search(params[:user])
    else
      @users = User.all
    end
  end
end

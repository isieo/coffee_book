class User::AccountsController < ApplicationController
  def index
    @user = current_user
  end
end

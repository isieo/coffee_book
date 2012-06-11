class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
    @jobs = Job.all
  end
end

class JobsController < ApplicationController
  def index
    if params[:job].present?
      @jobs = Job.search(params[:job])
    else
      @jobs = Job.all
    end
  end

  def show
    @job = Job.find(params[:id])
  end
end

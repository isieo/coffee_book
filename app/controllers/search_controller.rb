class SearchController < ApplicationController
  def search
    if params[:search].present?
      @search_job = Job.search(params[:search])
      if @search_job.count == 0
        @search_user = User.search(params[:search])
      end
    end
  end
  
  def advance_search
    #raise params.inspect
    if params[:job_title].present?
      @search_job = Job.where(:title => /params[:job_title]/)
    end
  end
end

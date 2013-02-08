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
    #if params[:search_type] == 'jobs'
      @search = Job.search(params[:q])
      @jobs = @search.all
    #end
  end
end

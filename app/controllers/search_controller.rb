class SearchController < ApplicationController
  
  def search
    @search_job = Job.search(params['job'])
    if @search_job.count == 0
      @search_user = User.search(params['user'])
    end
    

    respond_to do |format|
      format.html
      format.json { render json: @search }
    end
    
    
  end
  
end

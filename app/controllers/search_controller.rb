class SearchController < ApplicationController
  
  def search
    @search = Job.where(:title => params['search'])
    respond_to do |format|
      format.html
      format.json { render json: @search }
    end
  end
  
end

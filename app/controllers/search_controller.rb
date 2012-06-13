class SearchController < ApplicationController
  def search
    if params[:job].present?
      @search_job = Job.search(params['job'])
    else
      @search_user = User.search(params['user'])
    end
  end
end

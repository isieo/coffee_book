module JobsMacros
  def reset_jobs
    Job.delete_all
  end
  
  def create_job
    job = FactoryGirl.create(:job)
  end
end



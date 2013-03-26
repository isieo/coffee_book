module JobsMacros
  def reset_jobs
    Job.delete_all
  end
  
  def create_job
    job = FactoryGirl.create(:job)
  end
  
  def create_job_using_form
    login_first_time
    click_link "Company"
    click_link "Add new company"
    fill_in "Name", :with => "XYZ sdn bhd"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Contact mobile", :with => "Tesco Klang"
    fill_in "Contact office", :with => "Tesco Klang"
    click_button "save"
    page.should have_content("Company created successfully.")
    
    click_link "Company"
    click_link "View"
    click_link "New Job"
    fill_in "Title", :with => "new mock job"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Pay", :with => 100
    fill_in "Date", :with => Date.today + 15
    click_button "save"
    page.should have_content("Job created successfully.")
  end
end



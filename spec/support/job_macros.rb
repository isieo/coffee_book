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
    click_link "My Companies"
    click_link "New Company"
    fill_in "Name", :with => "XYZ sdn bhd"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Mobile", :with => "564624321635"
    fill_in "Office", :with => "654654846548"
    click_button "Save"
    page.should have_content("Company created successfully.")
    
    click_link "Company"
    click_link "My Companies"
    click_link "View"
    click_link "New Job"
    fill_in "Title", :with => "new mock job"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Pay", :with => 100
    fill_in "dpd1", :with => Date.today + 15
    click_button "Save"
    page.should have_content("Job created successfully.")
  end
end



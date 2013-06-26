require 'spec_helper'

describe "[Logined User Manipulate Job object] " do

  it "listing job page is accessible", js: true do
    create_company_using_form
    click_link "Company"
    click_link "My Companies"
    click_link "View"
    click_link "View all job"
    page.should have_content("Jobs created by")
  end
  
  it "create new job page is accessible", js: true  do
    create_company_using_form
    click_link "Company"
    click_link "My Companies"
    click_link "View"
    click_link "New Job"
    page.should have_content("Add New Job")
  end
  
  it "create new job using form", js: true  do
    create_job_using_form
    page.should have_content("new mock job")
  end

  it "view specific job page is accessible", js: true  do
    create_job_using_form
    click_link "Company"
    click_link "My Companies"
    click_link "View"
    click_link "View all job"
    click_link "View"
    #first(:link, "View").click
    page.should have_content("new mock job")
  end
  
  it "edit job using form", js: true  do
    create_job_using_form
    click_link "Company"
    click_link "My Companies"
    click_link "View"
    click_link "View all job"
    click_link "Edit"
    #find(:xpath, "(//a[text()='Edit'])[1]").click
    fill_in "Title", :with => "edited mock job test"
    click_button "Save"
    page.should have_content("Job updated successfully.")
    page.should have_content("edited mock job test")
  end
end







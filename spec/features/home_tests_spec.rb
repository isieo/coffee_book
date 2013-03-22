require 'spec_helper'
#encoding: utf-8

describe "Home and non-account user, " do
  #home
  it "home page is accessible" do
    visit root_path
    page.should have_content("Job")
  end
  it "guide page is accessible" do
    visit guide_path
    page.should have_content("Would you like to")
  end
  #company
  it "listing companies page is accessible" do
    visit companies_path
    page.should have_content("Companies Listing")
  end
  it "specific company page is accessible" do
    create_company
    visit companies_path
    first(:link, "Show").click
    page.should have_content("Testing Company")
  end
  #jobs
  it "listing jobs page is accessible" do
    visit jobs_path
    page.should have_content("Jobs Listing")
  end
  it "specific job page is accessible" do
    create_job
    visit jobs_path
    first(:link, "See More").click
    page.should have_content("testing title")
  end
  #user
  it "listing user page is accessible" do
    visit users_path
    page.should have_content("Users Listing")
  end
  it "specific user page is accessible" do
    create_user
    visit users_path
    first(:link, "Details").click
    page.should have_content("mock test")
  end
end




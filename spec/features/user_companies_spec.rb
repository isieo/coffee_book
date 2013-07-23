require 'spec_helper'

describe "[Logined User, Manipulating Company Object]" do

  it "listing companies page is accessible", js: true do
    login_first_time
    click_link "Company"
    click_link "My Companies"
    page.should have_content("Companies under")
  end
  
  it "create new company page is accessible", js: true do
    login_first_time
    click_link "Company"
    click_link "My Companies"
    click_link "New Company"
    page.should have_content("Add Company")
  end
  
  it "create new company using form", js: true do
    create_company_using_form
  end

  it "view specific company page is accessible", js: true do
    create_company_using_form
    #first(:link, "View").click
    click_link "Company"
    click_link "My Companies"
    click_on "View"
    page.should have_content("XYZ sdn bhd")
  end
  
  it "add new member to company", js: true do
    #create_company_using_form
    #click_link "Company"
    #click_link "Add Member"
    #fill_in "Group user", :with => "mock_auth_test_username"
    #page.should have_content("mock_auth_test_username")
  end
  
  it "edit company using form", js: true do
    create_company_using_form
    click_link "Company"
    click_link "My Companies"
    click_on "View"
    click_on "Update company details"
    #find(:xpath, "(//a[text()='Edit'])[1]").click
    fill_in "Name", :with => "MOCKING TEST sdn bhd"
    click_button "Save"
    page.should have_content("Company updated successfully.")
    page.should have_content("MOCKING TEST sdn bhd")
  end

  #it "delete company", js: true do
  #  create_company_using_form
  #  click_link "Company"
  #  click_link "My Companies"
  #  click_on "View"
  #  click_on "Delete"
  #  page.evaluate_script('window.confirm = function() { return true; }')
  #  page.should have_content("Company destroyed successfully.")
  #  page.should_not have_content("XYZ sdn bhd")
  #end
end







require 'spec_helper'

describe "login user to manipulate companies object, " do

  it "listing companies page is accessible" do
    login_first_time
    click_link "Company"
    page.should have_content("Companies under")
  end
  
  it "create new company page is accessible" do
    login_first_time
    click_link "Company"
    click_link "Add new company"
    page.should have_content("Add Company")
  end
  
  it "create new company using form" do
    create_company_using_form
  end

  it "view specific company page is accessible" do
    create_company_using_form
    first(:link, "View").click
    page.should have_content("XYZ sdn bhd")
  end
  
  it "add new member to company" do
    create_company_using_form
    click_link "Company"
    click_link "Add Member"
    fill_in "Group user", :with => "mock_auth_test_username"
    page.should have_content("mock_auth_test_username")
  end
  
  it "edit company using form" do
    create_company_using_form
    page.inspect
    find(:xpath, "(//a[text()='Edit'])[1]").click
    fill_in "Name", :with => "MOCKING TEST sdn bhd"
    click_button "save"
    page.should have_content("Company updated successfully.")
    page.should have_content("MOCKING TEST sdn bhd")
  end
end







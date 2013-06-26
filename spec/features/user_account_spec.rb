require 'spec_helper'

describe "[Logined User] " do
  it "log in" do
    login
    page.should have_content("mock_au...")
  end
  
  it "guide path for first time user after updating address" do
    login_first_time
    page.should have_content("Would you like to")
  end
  
  it "My account page is accessible", js: true do
    login_first_time
    click_link "mock_au..."
    click_link "View My Profile"
    page.should have_content("mock_auth_test")
    page.should have_content("foobar")
    page.should have_content("foobar@example.com")
  end

  it "Editing my details (Facebook login)", js: true do
    login_first_time
    click_link "mock_au..."
    click_link "Edit my details"
    fill_in "Name", :with => "edited name"
    fill_in "Mobile", :with => "145134251"
    click_button "Save"
    page.should have_content("You updated your account successfully.")
    page.should have_content("edited ...")
    click_link "edited ..."
    click_link "View My Profile"
    page.should have_content("edited name")
    page.should have_content("145134251")
  end
  
  it "Editing my details (Normal login)", js: true do
    normal_signup
    click_link "testname"
    click_link "Edit my details"
    fill_in "Name", :with => "edited name"
    fill_in "Mobile", :with => "145134251"
    fill_in "user_current_password", :with => "password"
    click_button "Save"
    page.should have_content("You updated your account successfully.")
    page.should have_content("edited ...")
    click_link "edited ..."
    click_link "View My Profile"
    page.should have_content("edited name")
    page.should have_content("145134251")
  end
  
  it "adding comment to my account", js: true  do
    login_first_time
    click_link "mock_au..."
    click_link "View My Profile"
    fill_in "comment", :with => "testing 123"
    click_button "Comment"
    page.should have_content("testing 123")
  end
  
  it "account map page is accessible" do
    login_first_time
    click_link "mock_au..."
    click_link "Jobs near me"
    page.should have_content("Klang")
  end
end


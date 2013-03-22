require 'spec_helper'

describe "login user, " do
  it "log in" do
    login
    page.should have_content("foobar")
  end
  
  it "update for the first time user" do
    login_first_time
  end
  
  it "guide path for first time user after updating address" do
    login_first_time
    page.should have_content("Would you like to")
  end
  
  it "My account page is accessible" do
    login_first_time
    click_link "My Account"
    page.should have_content("foobar")
  end
  
  it "My account page is accessible" do
    login_first_time
    click_link "My Account"
    page.should have_content("foobar")
  end
end







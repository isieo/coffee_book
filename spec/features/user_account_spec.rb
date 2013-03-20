require 'spec_helper'

describe "User Account Spec" do
  it "testing user account path" do
    visit root_path
    click_link "Login"
    page.should have_content("Name")
  end

end





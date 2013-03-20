require 'spec_helper'

describe "Home Spec" do
  it "testing root path" do
    visit root_path
    page.should have_content("Job")
  end
  it "testing guide path" do
    visit guide_path
    page.should have_content("Would you like to")
  end
end


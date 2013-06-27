module LoginMacros
  def normal_signup
    visit root_path
    click_link "Login"
    click_link "Sign up"
    fill_in "Email", :with => "test@example.dev"
    fill_in "Username", :with => "testusername"
    fill_in "Name", :with => "testname"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    fill_in "Location", :with => "Klang"
    click_on "Sign up"
    page.should have_content("testname")
  end

  def login
    visit root_path
    click_link "Login"
    click_link "Sign in with Facebook"
  end
  
  def login_first_time
    login
  end
end



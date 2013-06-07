module LoginMacros
  def normal_signup
    visit root_path
    click_link "Login"
    within('.pro-details') do
      fill_in "Email", :with => "test@example.dev"
      fill_in "Username", :with => "testusername"
      fill_in "Name", :with => "testname"
      fill_in "user_password", :with => "password"
      fill_in "user_password_confirmation", :with => "password"
    end
    click_on "Sign up"
    fill_in "Address", :with => "Tesco Klang"
    click_button"save"
  end

  def login
    visit root_path
    click_link "facebook"
  end
  
  def login_first_time
    login
    fill_in "Address", :with => "Tesco Klang"
    click_button 'save'
  end
end



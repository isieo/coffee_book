module LoginMacros
  def login
    visit root_path
    click_link "Login"
  end
  
  def login_first_time
    login
    fill_in "Address", :with => "Tesco Klang"
    click_button 'save'
  end
end



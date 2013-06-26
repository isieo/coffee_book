module CompaniesMacros
  def reset_companies
    Company.delete_all
  end
  
  def create_company
    company = FactoryGirl.create(:company)
  end
  
  def create_company_using_form
    login_first_time
    click_link "Company"
    click_link "My Companies"
    click_link "New Company"
    fill_in "Name", :with => "XYZ sdn bhd"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Mobile", :with => "564624321635"
    fill_in "Office", :with => "654654846548"
    click_button "Save"
    page.should have_content("Company created successfully.")
    visit root_path
  end
  
end



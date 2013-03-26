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
    click_link "Add new company"
    fill_in "Name", :with => "XYZ sdn bhd"
    fill_in "Address", :with => "Tesco Klang"
    fill_in "Contact mobile", :with => "564624321635"
    fill_in "Contact office", :with => "654654846548"
    click_button "save"
    page.should have_content("Company created successfully.")
  end
  
end



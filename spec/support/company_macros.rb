module CompaniesMacros
  def reset_companies
    Company.delete_all
  end
  
  def create_company
    company = FactoryGirl.create(:company)
  end
end



module UsersMacros
  def reset_users
    User.delete_all
  end
  
  def create_user
    user = FactoryGirl.create(:user)
  end
end



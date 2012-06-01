class User::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => :token

  def new
    super
  end

  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "You have signed up successfully."
      redirect_to root_url
    else
      @jobs = Job.all
      render :template => "home/show"
    end
  end

  def update
    super
  end
end
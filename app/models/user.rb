class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :authentication_keys => [:login]
  
  attr_accessible :name, :username, :email, :password, :password_confirmation, :address_street1, :address_street2, :post_code, :state, :country, :contact_mobile, :contact_home, :dob, :gender, :nationality, :ic_number, :login
  
  attr_accessor :login

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  
  field :name, :type => String, :null => false
  field :username, :type => String, :null => false
  field :address_street1, :type => String
  field :address_street2, :type => String
  field :post_code, :type => Integer
  field :state, :type => String
  field :country, :type => String
  field :contact_mobile, :type => String
  field :contact_home, :type => String
  field :dob, :type => Date
  field :gender, :type => String
  field :nationality, :type => String
  field :ic_number, :type => String

  
  #has_many :reviews
  has_many :companies, dependent: :delete
  has_and_belongs_to_many :jobs
  embeds_many :reviews

  
  validates_uniqueness_of :username, :email
  validates_presence_of :username, :name, :gender, :dob
  
  # Overwrite Devise authentication method
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    user_name = data.username
    user_name = data.email if data.username.blank?
    u_name = data.name
    u_name = data.email if data.name.blank?
    user = self.where(email: data.email).first
    if user.present?
      user.update(name: u_name, username: user_name, gender: data.gender)
      user
    else # Create a user with a stub password. 
      self.create(email: data.email, password: Devise.friendly_token[0,20], name: u_name, username: user_name, gender: data.gender) 
    end
  end
end

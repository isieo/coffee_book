class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

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
  
  field :name, :type => String
  field :username
  field :address_street1
  field :address_street2
  field :post_code
  field :state
  field :country
  field :contact_mobile
  field :contact_home
  field :dob
  field :gender
  field :nationality
  field :ic_number

  
  has_many :reviews
  has_many :companies
  
  validates_uniqueness_of :username, :email
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if data.username.blank?
      user_name = data.email
    else
      user_name = data.username
    end
    user = self.where(email: data.email).first
    if user.present?
      user.update(name: data.name, username: user_name, gender: data.gender)
      user
    else # Create a user with a stub password. 
      self.create(email: data.email, password: Devise.friendly_token[0,20], name: data.name, username: user_name, gender: data.gender) 
    end
  end
end

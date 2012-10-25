class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Search
  include Geocoder::Model::Mongoid
  
  geocoded_by :address do |obj,results|
    if geo = results.first
      obj.address = geo.address
      obj.city = geo.city
      obj.state = geo.state
      obj.country = geo.country
      obj.coordinates_latitude = geo.coordinates[0]
      obj.coordinates_longitude = geo.coordinates[1]
    end
  end
  
  reverse_geocoded_by :coordinates do |obj,results|
    if geo = results.first
      obj.address = geo.address
      obj.city = geo.city
      obj.state = geo.state
      obj.country = geo.country
      obj.coordinates_latitude = geo.coordinates[0]
      obj.coordinates_longitude = geo.coordinates[1]
    end
  end
  
  after_validation :geocode, :reverse_geocode, :if => (:address_changed? || :coordinates_latitude_changed? || :coordinates_longitude_changed?)
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :authentication_keys => [:login]
  
  attr_accessible :name, :username, :email, :password, :password_confirmation, :address,:coordinates_latitude,:coordinates_longitude ,:city, :state, :country, :contact_mobile, :contact_home, :dob, :gender, :nationality, :ic_number, :login, :cover_image
  
  attr_accessor :login, :image

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
  field :address, :type => String
  field :coordinates_latitude
  field :coordinates_longitude
  field :city
  field :state, :type => String
  field :country, :type => String
  field :contact_mobile, :type => String
  field :contact_home, :type => String
  field :dob, :type => Date
  field :gender, :type => String
  field :nationality, :type => String
  field :ic_number, :type => String
  field :cover_image_uid, :type => String
  field :fb_profile_pic, :type => String

  
#  has_many :companies
  has_and_belongs_to_many :admin_of, class_name: "Company"
  has_and_belongs_to_many :member_of, class_name: "Company"
  has_and_belongs_to_many :jobs
  embeds_many :reviews

  
  validates_uniqueness_of :username, :email
  validates_presence_of :username, :name
  
  search_in :name, :email, :username
  
  image_accessor :cover_image
  
  def to_param
    username
  end
  
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
      user.update_attributes(name: u_name, username: user_name, gender: data.gender)
      user.fb_profile_pic = "http://graph.facebook.com/#{data.id}/picture"
      user.save
      user
    else # Create a user with a stub password. 
      self.create(email: data.email, password: Devise.friendly_token[0,20], name: u_name, username: user_name, gender: data.gender) 
    end
    
  end
  
  # Company admin valification
  def is_company_admin?(company_id)
    @is_company_admin = self.admin_of_ids.include?(company_id)
  end
end

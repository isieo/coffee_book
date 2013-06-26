class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Search
  include Geocoder::Model::Mongoid
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,  :authentication_keys => [:login]

  attr_accessible :name, :username, :email, :password, :password_confirmation, :address,:coordinates_latitude,:coordinates_longitude ,:city, :state, :country, :contact_mobile, :contact_home, :dob, :gender, :nationality, :ic_number, :login
  attr_accessor :login, :image

  ## Database authenticatable
  field :email,              :type => String
  field :encrypted_password, :type => String
  validates :email, :presence => true, :uniqueness => true
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
  field :username, :type => String
  validates :name, presence: true
  validates :username, :presence => true, :uniqueness => true
  field :address, :type => String
  field :coordinates
  field :coordinates_latitude, :type => Float
  field :coordinates_longitude, :type => Float
  field :city
  field :state, :type => String
  field :country, :type => String
  field :contact_mobile, :type => String
  field :contact_home, :type => String
  field :dob, :type => Date
  field :gender, :type => String
  field :nationality, :type => String
  field :ic_number, :type => String
  field :image, :type => String
  field :fb_profile_pic, :type => String
  field :provider, :type => String
  field :uid
  
  before_validation :initialize_coordinates
  after_validation :geocode, :reverse_geocode, :if => (:address_changed? || :coordinates_latitude_changed? || :coordinates_longitude_changed?)
  
  #  has_many :companies
  has_and_belongs_to_many :admin_of, class_name: "Company"
  has_and_belongs_to_many :member_of, class_name: "Company"
  has_and_belongs_to_many :jobs
  has_many :job_applications
  embeds_many :reviews
  mount_uploader :image, PictureUploader

  validates_uniqueness_of :username, :email
  validates_presence_of :username, :name
  
  search_in :name, :email, :username
  
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
  
  def to_param
    username
  end
  
  #for login with both email and username
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
  
  #for devise facebook login
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.name = auth.info.name
      user.email = auth.info.email
      user.address = auth.info.location
      user.fb_profile_pic = auth.info.image#"http://graph.facebook.com/" + auth.uid + "/picture"
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  
  # Company admin valification
  def is_company_admin?(company_id)
    @is_company_admin = self.admin_of_ids.include?(company_id)
  end
  
  def initialize_coordinates
    self.coordinates = [self.coordinates_longitude.to_f, self.coordinates_latitude.to_f]
  end
end

class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
 
  field :name, :type => String
  field :coordinates
  field :coordinates_latitude
  field :coordinates_longitude
  field :address
  field :city
  field :state, :type => String
  field :country, :type => String
  field :contact_mobile, :type => String
  field :contact_office, :type => String
  field :cover_image_uid, :type => String
  
  before_validation :initialize_coordinates
  after_validation :geocode, :reverse_geocode, :if => (:address_changed? || :coordinates_latitude_changed? || :coordinates_longitude_changed?)

  attr_accessible :address, :coordinates_latitude, :coordinates_longitude
  attr_accessor :image, :group_user
  
  has_many :jobs
  embeds_many :reviews
  has_and_belongs_to_many :admins,  class_name: "User"
  has_and_belongs_to_many :members, class_name: "User"
  
  image_accessor :cover_image
  
  validates_presence_of :name, :address, :contact_mobile, :contact_office
  before_validation :initialize_coordinates
  
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
  
  protected
  def initialize_coordinates
    self.coordinates = [self.coordinates_longitude.to_f, self.coordinates_latitude.to_f]
  end
end

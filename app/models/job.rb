class Job
  include Mongoid::Document
  include Mongoid::Timestamps
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
  attr_accessible :address, :coordinates_latitude,:coordinates_longitude, :title, :position, :salary, :date, :day_amount, :time, :requirements, :city, :state, :country
  
  field :title, :type => String
  field :position, :type => String
  field :salary, :type => BigDecimal
  field :date, :type => Date
  field :day_amount, :type => Integer
  field :time, :type => Integer
  field :requirements, :type => String
  field :address
  field :city
  field :coordinates
  field :coordinates_latitude
  field :coordinates_longitude
  field :state, :type => String
  field :country, :type => String
  field :applicant, :type => Array
  
  belongs_to :company
  has_and_belongs_to_many :users
  
  search_in :title, :position, :city, :salary, :date, :company_name, :address, :state, :country
  
  before_validation :initialize_applicant, :initialize_coordinates
  
  validates_presence_of :title, :address
  
  protected
  def initialize_applicant
    if self.applicant == nil
      self.applicant = []
    end
  end
  
  def initialize_coordinates
    self.coordinates = [self.coordinates_latitude, self.coordinates_longitude]
  end
end

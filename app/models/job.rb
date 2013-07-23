class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Geocoder::Model::Mongoid
  
  field :title, :type => String
  validates :title, presence: true
  field :position, :type => String
  field :pay, :type => BigDecimal
  field :pay_per, :type => String
  field :date, :type => Date
  field :day_amount, :type => Integer
  field :time, :type => Integer
  field :requirements, :type => String
  field :address
  field :city
  field :coordinates
  field :coordinates_latitude, :type => Float
  field :coordinates_longitude, :type => Float
  field :state, :type => String
  field :country, :type => String
  
  before_validation :initialize_coordinates
  after_validation :geocode, :reverse_geocode, :if => (:address_changed? || :coordinates_latitude_changed? || :coordinates_longitude_changed?)
  
  attr_accessible :address, :coordinates_latitude,:coordinates_longitude, :title, :position, :salary, :date, :day_amount, :time, :requirements, :city, :state, :country, :summary
  
  belongs_to :company
  has_and_belongs_to_many :users
  has_many :job_applications
  
  search_in :title, :position, :city, :salary, :date, :company_name, :address, :state, :country
  
  before_validation :initialize_coordinates
  
  validates_presence_of :title, :address, :pay
  
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
  
  #reverse_geocoded_by :coordinates do |obj,results|
  #  if geo = results.first
  #    obj.address = geo.address
  #    obj.city = geo.city
  #    obj.state = geo.state
  #    obj.country = geo.country
  #    obj.coordinates_latitude = geo.coordinates[0]
  #    obj.coordinates_longitude = geo.coordinates[1]
  #  end
  #end
  
  def summary
    "#{title}, salary RM#{'%.2f' % salary} "
  end
  
  protected
  
  def initialize_coordinates
    self.coordinates = [self.coordinates_longitude.to_f, self.coordinates_latitude.to_f]
  end
end

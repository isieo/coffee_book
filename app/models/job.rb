class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  
  field :title, :type => String
  field :position, :type => String
  field :location, :type => String
  field :salary, :type => BigDecimal
  field :date, :type => Date
  field :day_amount, :type => Integer
  field :time, :type => Integer
  field :requirements, :type => String
  field :company_name, :type => String
  field :contact_mobile, :type => String
  field :contact_office, :type => String
  field :address_street1, :type => String
  field :address_street2, :type => String
  field :post_code, :type => String
  field :state, :type => String
  field :country, :type => String
  field :applicant, :type => Array
  
  belongs_to :company
  has_and_belongs_to_many :users
  
  search_in :title, :position, :location, :salary, :date, :company_name, :address_street1, :address_street2, :post_code, :state, :country
end

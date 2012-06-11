class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  
  field :title, :type => String
  field :post, :type => String
  field :location, :type => String
  field :salary, :type => BigDecimal
  field :date, :type => Date
  field :day_amount, :type => Integer
  field :time, :type => Integer
  field :requirements, :type => String
  
  belongs_to :company
  has_and_belongs_to_many :users
  
  search_in :title, :post,:location,:salary,:date
end

class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :post, :type => String
  field :location, :type => String
  field :salary, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :time, :type => String
  field :requirements, :type => String
  
  belongs_to :company
end

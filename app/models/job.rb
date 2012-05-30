class Job
  include Mongoid::Document
  field :title, :type => String
  field :location, :type => String
  field :salary, :type => String
  field :date, :type => Date
  field :time, :type => String
  field :requirements, :type => String
  
  belongs_to :company
end

class JobApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Geocoder::Model::Mongoid
  
  field :username
  field :status, :type => String, :default => "pending"
  field :available_day
  field :reject_reason
  field :applicant_description
  
  belongs_to :job
  belongs_to :company
  belongs_to :user
end

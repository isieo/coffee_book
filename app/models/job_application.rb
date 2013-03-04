class JobApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Geocoder::Model::Mongoid
  
  field :username
  field :status, :type => String, :default => "pending"
  
  belongs_to :job
  belongs_to :company
  belongs_to :user
end

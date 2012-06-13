class Achievement
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String, :null => false
  field :industry, :type => String, :null => false
  field :date_joined, :type => Date
  field :date_left, :type => Date
  field :position_title, :type => String
  field :specialization, :type => String
  field :role, :type => String, :null => false
  field :position_level, :type => String
  field :currency_code, :type => String
  field :salary, :type => Float
  field :work_description, :type => String
  
  validates_presence_of :name, :industry, :date_joined, :position_title, :specialization, :role, :position_level
  
  embedded_in :user
  
end

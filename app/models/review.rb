class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :comment, :type => String
  field :post_to
  
  #belongs_to :user
  #belongs_to :company
  embedded_in :user
  embedded_in :company
end

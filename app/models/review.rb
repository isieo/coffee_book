class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :comment, :type => String
  field :post_to
  
  belongs_to :user
  belongs_to :company
end

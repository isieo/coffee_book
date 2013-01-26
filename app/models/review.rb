class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :comment, :type => String
  #field :post_by, :type => String
  field :rating, :type => Integer
  
  belongs_to :poster, :class_name => "User", inverse_of: nil
  #belongs_to :company
  embedded_in :user
  embedded_in :company
end

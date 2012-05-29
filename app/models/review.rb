class Review
  include Mongoid::Document
  field :comment, :type => String
  field :post_to, :type => String
  embedded_in :user
  embedded_in :company
end

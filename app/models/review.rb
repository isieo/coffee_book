class Review
  include Mongoid::Document
  field :comment, :type => String
  field :post_to, :type => String
  field :type
  field :poster
  embedded_in :user
end

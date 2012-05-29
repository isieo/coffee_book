class Company
  include Mongoid::Document

  field :name, :type => String
  field :email
  field :address_street1, :type => String
  field :address_street2, :type => String
  field :post_code, :type => String
  field :state, :type => String
  field :country, :type => String
  field :contact_mobile, :type => String
  field :contact_office, :type => String
  
  embedded_in :user
end

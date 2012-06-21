class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :company_name, :type => String
  field :address_street1, :type => String
  field :address_street2, :type => String
  field :post_code, :type => String
  field :state, :type => String
  field :country, :type => String
  field :contact_mobile, :type => String
  field :contact_office, :type => String
  field :cover_image_uid, :type => String
  
  attr_accessor :image, :group_user
  
  has_many :jobs
  embeds_many :reviews
#  belongs_to :user
  has_and_belongs_to_many :admins,  class_name: "User"
  has_and_belongs_to_many :members, class_name: "User"
  
  image_accessor :cover_image
  
  validates_presence_of :name, :address_street1, :post_code, :state, :country, :contact_mobile, :contact_office
  
end

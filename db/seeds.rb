# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_create_by(email: "xyz@abc.com")
user.password = "abcxyz"
user.name = "David"
user.username = "David1"
user.address_street1 = "10, Jalan gila"
user.address_street2 = 'taman buta'
user.post_code = "41200"
user.state = "selangor"
user.country = "malaysia"
user.contact_mobile = "016-3177489"
user.contact_home = "999"
user.dob = "11-08-1985"
user.gender = "male"
user.nationality = "Malaysian"
user.ic_number = "881010-10-5612"
puts user.save

company = user.companies.find_or_create_by(name: "abc sdn bhd")
company.email = "abc@sdn.com"
company.address_street1 = "10, Jalan wahhahaa"
company.address_street2 = 'taman wohohoho'
company.post_code = "55500"
company.state = "selangor"
company.country = "malaysia"
company.contact_mobile = "994"
company.contact_office = "991"
puts company.save

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

job = company.jobs.find_or_create_by(title: "games promoter")
job.post = "Promoter"
job.location = "Giant Kelana Jaya"
job.salary = "RM120/day"
job.start_date = "11-08-2012"
job.end_date = "13-08-2012"
job.time = "10am to 10pm"
job.requirements = "* Hardworking, Aggressive, punctuality, have road show promoter experience. (Must be Female)
* Must able to speak English / Malay
* Must able to attend training (training date: 10th Aug 3pm)
* NO blonde hair,NO ear piercing
* Attire: Uniform shirt (provided), own black pant & black cover shoe."
job.save

job2 = company.jobs.find_or_create_by(title: "Pamphlet Distributor")
job2.post = "Distributor"
job2.location = "Paradigm Mall Kelana Jaya"
job2.salary = "RM100/day"
job.start_date = "15-08-2012"
job.end_date = "18-08-2012"
job2.time = "10am to 10pm"
job2.requirements = "* Hardworking, Aggressive, punctuality, have road show promoter experience.
* Must able to speak English / Malay
* Must able to attend training (training date: 10th Aug 3pm)
* Attire: Uniform shirt (provided), own black pant & black cover shoe."
job2.save

user2 = User.find_or_create_by(email: "final@abc.com")
user2.password = "abcxyz"
user2.name = "Tidus"
user2.username = "Brother"
user2.address_street1 = "10, Jalan gila"
user2.address_street2 = 'taman buta'
user2.post_code = "41200"
user2.state = "selangor"
user2.country = "malaysia"
user2.contact_mobile = "016-3177489"
user2.contact_home = "999"
user2.dob = "11-08-1985"
user2.gender = "male"
user2.nationality = "Malaysian"
user2.ic_number = "881010-10-5612"
puts user2.save


review = user.reviews.find_or_create_by(comment: "this company/person is good")
review.company = company
review.post_to = user2.id
puts review.save


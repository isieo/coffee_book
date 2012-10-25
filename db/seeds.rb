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
user.address = "Tesco Bukit Tinggi"
user.contact_mobile = "016-3177489"
user.contact_home = "999"
user.dob = "11-08-1985"
user.gender = "Male"
user.nationality = "Malaysian"
user.ic_number = "881010-10-5612"
puts "user save " + user.save.to_s

company = user.admin_of.find_or_create_by(name: "abc sdn bhd")
company.name = "abc sdn bhd"
company.address = "Tesco Bukit Tinggi"
company.contact_mobile = "994"
company.contact_office = "991"
puts "company save " + company.save.to_s

job = company.jobs.find_or_create_by(title: "games promoter")
job.title = "games promoter"
job.position = "Promoter"
job.address = "Giant Kelana Jaya"
job.salary = 120
job.date = "11-08-2012"
job.day_amount = 5
job.time = 10
job.requirements = "* Hardworking, Aggressive, punctuality, have road show promoter experience. (Must be Female)
* Must able to speak English / Malay
* Must able to attend training (training date: 10th Aug 3pm)
* NO blonde hair,NO ear piercing
* Attire: Uniform shirt (provided), own black pant & black cover shoe."
puts "job save " + job.save.to_s

job2 = company.jobs.find_or_create_by(title: "Pamphlet Distributor")
job2.title = "Pamphlet Distributor"
job2.position = "Distributor"
job2.address = "Paradigm Mall Kelana Jaya"
job2.salary = 100
job2.date = "15-08-2012"
job2.day_amount = 3
job2.time = 8
job2.requirements = "* Hardworking, Aggressive, punctuality, have road show promoter experience.
* Must able to speak English / Malay
* Must able to attend training (training date: 10th Aug 3pm)
* Attire: Uniform shirt (provided), own black pant & black cover shoe."
puts "job2 save " + job2.save.to_s

job3 = company.jobs.find_or_create_by(title: "Road Show Model")
job3.title = "Road Show Model"
job3.position = "Road Show"
job3.address = "Tropicana Mall Petaling Jaya"
job3.salary = 300
job3.date = "18-08-2012"
job3.day_amount = 2
job3.time = 6
job3.requirements = "* Female Only, have road show model experience.
* Must able to attend training (training date: 10th Aug 3pm)
* Attire: Uniform(provided)"
puts "job3 save " + job3.save.to_s

user2 = User.find_or_create_by(email: "final@abc.com")
user2.password = "abcxyz"
user2.name = "Tidus"
user2.username = "Brother"
user2.address = "Times Square Kuala Lumpur"
user2.contact_mobile = "016-3177489"
user2.contact_home = "999"
user2.dob = "11-08-1985"
user2.gender = "male"
user2.nationality = "Malaysian"
user2.ic_number = "881010-10-5612"
puts "user2 save " + user2.save.to_s


user_review = user.reviews.find_or_create_by(comment: "this person is hardworking")
user_review.post_by = user2.username
puts "user review save " + user_review.save.to_s

company_review = company.reviews.find_or_create_by(comment: "this company pay salary in time!")
company_review.post_by = user2.username
puts "company review save " + user_review.save.to_s

if user.jobs.empty?
  user.jobs << job
  user.jobs << job2
  user.jobs << job3
  puts "many to many (users to jobs vice versa) save " + user.save.to_s
end


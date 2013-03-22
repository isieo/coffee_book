FactoryGirl.define do

  factory :user do

    name "mock test"
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:username) { |n| "mock#{n}" }
    address "mocking street"
    #coordinates ""
    #coordinates_latitude ""
    #coordinates_longitude ""
    city "klang"
    state "Selangor"
    country "Malaysia"
    contact_mobile "12412"
    contact_home "124124"
    #dob
    gender "Male"
    password 'secret'
  end
  
  factory :company do
    admins {[FactoryGirl.create(:user)]}
    members {[FactoryGirl.create(:user)]}
    #admins [user]
    #members [user]
    name "Testing Company"
    #coordinates ""
    #coordinates_latitude ""
    #coordinates_longitude ""
    address "testing address"
    city "pj"
    state "Selangor"
    country "Malaysia"
    contact_mobile "123412"
    contact_office "124312431"
  end
  
  factory :job do
    association :company, factory: :company
    title "testing title"
    position "tester"
    pay 199
    pay_per  "Per Day"
    date Date.today + 15
    day_amount 10
    requirements "asdfasfsafaaa"
    address "Jalan Bukit Tinggi"
    city "Klang"
    #coordinates
    #coordinates_latitude
    #coordinates_longitude
    state "Selangor"
    country "Malaysia"
  end
end

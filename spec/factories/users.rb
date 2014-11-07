FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) {|n| "valid_email_#{n}@email.com"}    
    password Faker::Internet.password(12)
  end

end

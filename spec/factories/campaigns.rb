FactoryGirl.define do
  factory :campaign do
    association :user, factory: :user
    title Faker::Company.bs
    description Faker::Lorem.paragraph
    goal 10000 
    deadline (Time.now+10.days)
  end

end

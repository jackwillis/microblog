FactoryGirl.define do
  sequence :username do |n| "user#{n}" end
  sequence :handle do |n| "User #{n}" end
  sequence :email do |n| "user#{n}@example.invalid" end
end


FactoryGirl.define do
  factory :user do
    username
    handle
    email
    password { rand.to_s }
  end
end

FactoryGirl.define do
  factory :post do
    body { SecureRandom.urlsafe_base64(rand(100) + 10) }
    user
  end
end
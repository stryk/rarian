# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :target_price do
    company_id 1
    user_id 1
    year 1
    target_price "20.00"
  end
end

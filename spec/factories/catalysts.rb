# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :catalyst do
    user_id 1
    company_id 1
    content "MyText"
    date "2013-08-20"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :risk do
    company_id 1
    user_id 1
    risk "MyString"
  end
end

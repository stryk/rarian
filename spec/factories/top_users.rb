# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :top_user do
    company_id 1
    user_id 1
    no_of_up_votes 1
    no_of_down_votes 1
    no_of_votes 1
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :most_active_ticker do
    company_id 1
    no_of_up_votes 1
    no_of_down_votes 1
    no_of_votes 1
    active_date Date.today
  end
end

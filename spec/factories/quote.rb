FactoryGirl.define do
  factory :quote do
    price 12.6
    market_cap  "200"
    date_time Time.now
  end
end
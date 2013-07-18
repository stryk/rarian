FactoryGirl.define do
  factory :company do
    name "Google"
    ticker "Goog"
    exchange "Nasdaq"
    sector "Capital Goods"
    industry "online"
    factory :company_with_quotes do
      after(:create) do |company, evaluator|
        FactoryGirl.create_list(:quote, 1, company: company)
      end
    end
  end
end
FactoryGirl.define do
  factory :blip do
    action "buy"
    content  "This is a good time to buy the shares and keep it for long term"
    quantity 20
    association :company
    association :user
  end
end
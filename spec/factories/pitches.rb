# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pitch do
    title "title"
    multimedia_content "<p>Hi</p>"
    action "buy"
    association :user
    association :company
  end
end

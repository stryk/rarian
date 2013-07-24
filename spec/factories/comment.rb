FactoryGirl.define do
  factory :comment do
    comment  "This is a good time to buy the shares and keep it for long term"
    association :commentable, :factory =>  :blip
    association :user
  end
end
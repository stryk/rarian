# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    description "MyString"
    company_id 1
    user_id 1
    attachable_id 1
    attachable_type "MyString"
    file_type "MyString"
    file_size_in_kb 1
    file_name "MyString"
    attached_file "MyString"
  end
end

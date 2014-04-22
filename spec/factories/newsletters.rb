# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :newsletter do
    released_at nil
    title "MyString"
    description "MyText"
    asset { fixture_file_upload('spec/support/test.pdf', 'application/pdf') }
  end
end

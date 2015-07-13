FactoryGirl.define do
  factory :word do
    content {Faker::Lorem.word}
  end
end

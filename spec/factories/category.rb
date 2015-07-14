FactoryGirl.define do
  factory :category do
    cat_name {Faker::Name.name}
    icon {Faker::Avatar.image}
    description {Faker::Lorem.sentence}
  end
end

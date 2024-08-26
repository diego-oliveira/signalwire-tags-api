FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.sentence(word_count: 3) }
    user_id { Faker::Number.number(digits: 10) }

    trait :with_tags do
      transient do
        tags_count { 2 }
      end

      after(:create) do |ticket, evaluator|
        create_list(:tag, evaluator.tags_count, tickets: [ticket])
      end
    end
  end
end

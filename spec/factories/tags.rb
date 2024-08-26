FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag #{n}" }
    taggings_count { 0 }

    # If you want to create a tag with associated taggings
    trait :with_taggings do
      transient do
        taggings_count { 3 }
      end

      after(:create) do |tag, evaluator|
        create_list(:tagging, evaluator.taggings_count, tag: tag)
        tag.reload
      end
    end
  end
end

FactoryBot.define do
  factory :tagging do
    association :ticket
    association :tag
  end
end

FactoryBot.define do
  factory :team_membership do
    association :user
    association :team
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end

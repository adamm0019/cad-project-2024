FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    description { "A test team description" }
    association :user  # Team owner

    trait :with_members do
      after(:create) do |team|
        create(:team_membership, team: team, user: team.user, admin: true)  # Owner is admin
        create(:team_membership, team: team)  # Regular member
      end
    end

    trait :with_projects do
      after(:create) do |team|
        create_list(:project, 2, team: team, user: team.user)
      end
    end
  end
end

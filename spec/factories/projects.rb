FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description { "A test project description" }
    status { 0 }  # active

    association :user
    
    transient do
      with_team { true }
    end

    before(:create) do |project, evaluator|
      if evaluator.with_team
        team = create(:team, user: project.user)
        project.team = team
      end
    end

    trait :with_tasks do
      after(:create) do |project|
        create_list(:task, 3, project: project, user: project.user)
      end
    end

    trait :completed do
      status { 2 }
    end

    trait :on_hold do
      status { 1 }
    end
  end
end

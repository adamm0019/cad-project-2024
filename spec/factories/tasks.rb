FactoryBot.define do
  factory :task do
    title { "Test Task" }
    description { "This is a test task description" }
    status { :pending }
    priority { :medium }
    due_date { 1.week.from_now }
    association :project
    association :user
  end

  trait :in_progress do
    status { :in_progress }
  end

  trait :completed do
    status { :completed }
  end

  trait :high_priority do
    priority { :high }
  end

  trait :low_priority do
    priority { :low }
  end

  trait :overdue do
    due_date { 1.week.ago }
  end
end

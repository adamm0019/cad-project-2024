class Project < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :user, presence: true
  validates :team, presence: true

  enum :status, {
    active: 0,
    on_hold: 1,
    completed: 2
  }, default: :active

  def completion_rate
    return 0 if tasks.empty?
    ((tasks.completed.count.to_f / tasks.count) * 100).round
  end

  def status_distribution
    tasks.group(:status).count
  end

  def projects_by_month
    tasks.group_by_month(:created_at).count
  end
end

class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :user_id, uniqueness: { scope: :team_id }
  validates :user, presence: true
  validates :team, presence: true
end

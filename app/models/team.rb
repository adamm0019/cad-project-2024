class Team < ApplicationRecord
  belongs_to :user  # Team owner
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects

  validates :name, presence: true
  validates :user, presence: true

  after_create :add_owner_as_admin_member

  private

  def add_owner_as_admin_member
    team_memberships.create!(user: user, admin: true)
  end
end

# app/models/task.rb
class Task < ApplicationRecord
    belongs_to :project
    belongs_to :user
  
    validates :title, presence: true
    validates :description, presence: true
    validates :status, presence: true
    validates :priority, presence: true
  
    enum status: {
      pending: 0,
      in_progress: 1,
      completed: 2
    }
  
    enum priority: {
      low: 0,
      medium: 1,
      high: 2
    }
  end
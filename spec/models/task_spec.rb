require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:priority) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, in_progress: 1, completed: 2) }
    it { should define_enum_for(:priority).with_values(low: 0, medium: 1, high: 2) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:task)).to be_valid
    end

    it 'is valid with different statuses' do
      expect(build(:task, :in_progress)).to be_valid
      expect(build(:task, :completed)).to be_valid
    end

    it 'is valid with different priorities' do
      expect(build(:task, :high_priority)).to be_valid
      expect(build(:task, :low_priority)).to be_valid
    end
  end

  describe 'scopes and queries' do
    let!(:completed_task) { create(:task, :completed) }
    let!(:pending_task) { create(:task) }
    let!(:overdue_task) { create(:task, :overdue) }
    let!(:high_priority_task) { create(:task, :high_priority) }

    it 'can filter by status' do
      expect(Task.completed).to include(completed_task)
      expect(Task.pending).to include(pending_task)
    end

    it 'can filter by priority' do
      expect(Task.high).to include(high_priority_task)
    end

    it 'can identify overdue tasks' do
      expect(Task.where('due_date < ?', Time.current)).to include(overdue_task)
    end
  end

  describe 'business logic' do
    let(:task) { create(:task) }

    it 'starts in pending status' do
      expect(task.status).to eq('pending')
    end

    it 'can transition through statuses' do
      expect(task.status).to eq('pending')
      
      task.update(status: :in_progress)
      expect(task.status).to eq('in_progress')
      
      task.update(status: :completed)
      expect(task.status).to eq('completed')
    end

    it 'can change priorities' do
      expect(task.priority).to eq('medium')
      
      task.update(priority: :high)
      expect(task.priority).to eq('high')
      
      task.update(priority: :low)
      expect(task.priority).to eq('low')
    end
  end
end

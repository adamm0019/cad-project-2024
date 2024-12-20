require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:team) { create(:team, user: user) }
  let(:project) { create(:project, user: user, team: team) }
  
  let(:valid_attributes) do
    {
      title: "Test Task",
      description: "Test Description",
      status: "pending",
      priority: "medium",
      due_date: 1.week.from_now,
      project_id: project.id,
      user_id: user.id
    }
  end

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { project_id: project.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Task' do
        expect {
          post :create, params: { project_id: project.id, task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it 'redirects to the project page' do
        post :create, params: { project_id: project.id, task: valid_attributes }
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'with invalid params' do
      it 'does not create a new task' do
        expect {
          post :create, params: { project_id: project.id, task: { title: nil } }
        }.to_not change(Task, :count)
      end

      it 're-renders the new template' do
        post :create, params: { project_id: project.id, task: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let(:task) { create(:task, project: project, user: user) }

    context 'with valid params' do
      let(:new_attributes) do
        {
          title: "Updated Title",
          status: "in_progress"
        }
      end

      it 'updates the requested task' do
        patch :update, params: { id: task.id, task: new_attributes }
        task.reload
        expect(task.title).to eq("Updated Title")
        expect(task.status).to eq("in_progress")
      end

      it 'redirects to the project' do
        patch :update, params: { id: task.id, task: new_attributes }
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        patch :update, params: { id: task.id, task: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create(:task, project: project, user: user) }

    it 'destroys the requested task' do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to the project page' do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(project_path(project))
    end
  end

  describe 'Task status transitions' do
    let(:task) { create(:task, project: project, user: user) }

    it 'can mark a task as in progress' do
      patch :update, params: { id: task.id, task: { status: 'in_progress' } }
      task.reload
      expect(task.status).to eq('in_progress')
    end

    it 'can mark a task as completed' do
      patch :update, params: { id: task.id, task: { status: 'completed' } }
      task.reload
      expect(task.status).to eq('completed')
    end
  end

  describe 'Task priority management' do
    let(:task) { create(:task, project: project, user: user) }

    it 'can change task priority' do
      patch :update, params: { id: task.id, task: { priority: 'high' } }
      task.reload
      expect(task.priority).to eq('high')
    end
  end
end

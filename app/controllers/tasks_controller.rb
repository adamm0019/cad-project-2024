# This controller handles all actions related to tasks, including creating, reading, updating, and deleting tasks.
# It also handles task associations with projects and users.


class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create]
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @task = @project.tasks.build
  end

  def edit
  end

  def create
    @task = @project.tasks.build(task_params)
    @task.user = current_user

    if @task.save
      redirect_to project_path(@project), notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_path(@task.project), notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    project = @task.project
    @task.destroy
    redirect_to project_path(project), notice: 'Task was successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :due_date)
  end
end

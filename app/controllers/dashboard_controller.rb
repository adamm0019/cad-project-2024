# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.teams
    if @teams.any?
      @projects = Project.where(team: @teams)
      @recent_projects = @projects.order(created_at: :desc).limit(5)
      @tasks_due_soon = Task.where(project_id: @projects.pluck(:id))
                           .where('due_date >= ?', Date.today)
                           .order(due_date: :asc)
                           .limit(5)
    else
      @projects = []
      @recent_projects = []
      @tasks_due_soon = []
    end
  end
end

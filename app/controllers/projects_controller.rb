# This controller handles all actions related to projects, including creating, reading, updating, and deleting projects.

class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_team, only: [:new, :create]
    before_action :set_project, only: [:show, :edit, :update, :destroy]
  
    def index
      @teams = current_user.teams
      @projects = Project.where(team: @teams).includes(:user, :team)
    end
  
    def show
      @tasks = @project.tasks.includes(:user)
    end
  
    def new
      @project = @team.projects.build
    end
  
    def create
      @project = @team.projects.build(project_params)
      @project.user = current_user

      if @project.save
        redirect_to @project, notice: 'Project was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @teams = current_user.teams
    end
  
    def update
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        @teams = current_user.teams
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @project.destroy
      redirect_to projects_url, notice: 'Project was successfully deleted.'
    end
  
    private
  
    def set_team
      @team = Team.find(params[:team_id])
    end

    def set_project
      @project = Project.find(params[:id])
    end
  
    def project_params
      params.require(:project).permit(:name, :description, :status)
    end
  end

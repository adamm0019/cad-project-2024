# This controller handles all actions related to teams, including creating, reading, updating, and deleting teams.
# It also handles team membership and associations with projects.


class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = current_user.teams
  end

  def show
    @team_members = @team.users
    @projects = @team.projects.includes(:user)
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    @team_membership = TeamMembership.new(team: @team, user: current_user, admin: true)

    if @team.save && @team_membership.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully deleted.'
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end

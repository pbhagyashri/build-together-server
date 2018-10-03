class Api::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :project_comments]

  def index
  end

  def create 
    
    project = Project.new(project_params)
    binding.pry
    if project.save
      
      render json: project, status: 200

    else

      render json: {message: project.errors}, status: 400
    
    end

  end

  def show
  end

  def update
  end

  def destroy
  end

  private 

  def project_params
    params.require(:project).permit(:name, :technologies, :description, :duration, :user_id, :user_name, :github_link, :comments => [])
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

end
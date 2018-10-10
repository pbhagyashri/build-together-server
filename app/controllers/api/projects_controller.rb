class Api::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :project_comments]

  def index
    projects = Project.all
    
    if projects
      render json: projects, status: 200
    else
      render json: {message: "no projects found"}, status: 400
    end
    
  end

  def create 

    project = Project.new(project_params)
      
      if project.save
        render json: {name: project.name, technology: project.technology, description: project.description, duration: project.duration, num_of_likes: project.likes}, status: 200
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
    params.require(:project).permit(:name, :technologies, :description, :duration, :github_link, :comments => [])
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

end
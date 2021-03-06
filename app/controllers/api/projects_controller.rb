require 'auth'

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
  
    token = request.headers["HTTP_AUTHORIZATION"]
    
    current_user = authenticate_user(token)
    
    if current_user
    
      project = current_user.projects.build(project_params)
      #project.author = current_user.username
      if project.save
        render json: {project: project, user: project.user}, status: 200
      else
        render json: {message: project.errors}, status: 400
      end
    end
  end

  def show
    if @project
      render json: @project, status: 200
    else
      render json: {message: "Project not found"}, status: 400
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: 200
    else
      render json: {error: @project.errors}, status: 400
    end
  end

  def destroy
  end


  private 

  def authenticate_user(token)
    user_id = Auth.decode_token(token)["id"]
    current_user = User.find_by(id: user_id)
  end
 
  def project_params
    params.require(:project).permit(:name, :technologies, :description, :duration, :github_link, :comments => [])
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

end

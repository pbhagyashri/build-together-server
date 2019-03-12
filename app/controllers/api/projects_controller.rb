require 'auth'

class Api::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :project_comments]
  before_action :authenticate_user?, only: [:show, :update, :destroy]

  def index
    if params["user_id"]
    
      user = User.all.find_by(id: params["user_id"])
      user_projects = user.projects

      if user_projects
        render json: user_projects, status: 200
      else
        render json: {message: "no projects found"}, status: 400
      end
    
    else

      projects = Project.all
    
      if projects
        render json: projects, status: 200
      else
        render json: {message: "no projects found"}, status: 400
      end

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
 
  def project_params
    params.require(:project).permit(:name, :technologies, :description, :duration, :github_link, :comments => [])
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def authenticate_user?
    #extract token from request header
    token = request.headers["HTTP_TOKEN"]
    
    #Use extracted token to verify user is a valid user
    decoded_user = Auth.decode_token(token)
  
    decoded_user && user_params["email"] == decoded_user["email"] ? true : false
    # decoded_user && decoded_user.update(user_params) ? true : false
  end

end

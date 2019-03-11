require 'auth'

class Api::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy, :user_projects]
  before_action :authenticate_user?, only: [:show, :update, :destroy, :user_projects]

  def index
    @users = User.all
    render json: @users
  end

  def create
    
    user = User.new(user_params)
    if user.save
      token = Auth.create_token(user)
      render json: {user: { id: user.id, username: user.username, email: user.email, token: token}}, status: 200    
    else
      render json: {errors: "Email already exists"}, status: 400
    end
  end

  def show
    binding.pry
    # if authenticate_user? && @user
    #   render json: @user, status: 200
    # else
    #   render json: {message: "User not found"}, status: 400
    # end
  end

  def update
   
    if authenticate_user? && @user.update(user_params)
      #create a new token and send to front-end
      newToken = Auth.create_token(user_params)
      
      render json: {token: newToken}, status: 200     
    else
      binding.pry
      render json: {error: "There was an error reseting your password. Please try again"}, status: 400
    end
  end

  def destroy
    if authenticate_user? && @user.destroy
      render status: 204
    else
      render json: {message: "Unable to process your request"}, status: 400
    end
  end

  def user_projects
    if authenticate_user?
      binding.pry
      user_projects = @user.projects 
      if user_projects
        render json: user_projects
      else
        render json: {message: "Sorry no projects found"}, status: 400
      end
    
    else
      render json: {message: "Sorry unable to process your request"}, status: 400
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :username, :email, :new_password)
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
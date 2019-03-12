require 'auth'

class Api::SessionsController < ApplicationController

  def create
 
    user = User.find_by(email: params[:email])
    
    if user && user.valid_password?(params[:password])
      token = Auth.create_token(user)
      render json: {user: { id: user.id, username: user.username, email: user.email }, token: token}, status: 200
    else
      render json: {errors: "Email or Password is incorrect"}, status: 400
    end

  end

  def find
    user = Auth.decode_token(params[:token])
    
    if user
      render json: { user: { id: user.id, username: user.username, email: user.email} }
    else
      render json: { errors: { message: "Unable to find user" } }, status: 401
    end
  end

  # private

  # def session_params
  #   params.require(:session).permit(:password, :password_confirmation, :email)
  # end


end
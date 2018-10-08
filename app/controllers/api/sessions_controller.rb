require 'auth'

class Api::SessionsController < ApplicationController

  def create
  
    user = User.find_by(email: params[:user][:email])
    
    if user && user.valid_password?(params[:user][:password])
      token = Auth.create_token(user)
      render json: {user: { id: user.id, username: user.username, email: user.email }, token: token}, status: 200
    else
      render json: {errors: "Email or Password is incorrect"}, status: 400
    end

  end


end
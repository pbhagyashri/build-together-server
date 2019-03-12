require 'auth'

class Api::CommentsController < ApplicationController

	before_action :authenticate_user?, only: [:update, :destroy,]

	def create 
		if authenticate_user?
			
			comment = Comment.new(comment_params)
			if comment.save
				render json: comment, status: 200
			else
				render json: comment.errors, status: 400
			end

		else
			render json: {message: "Sorry we could not process your request. Please login with correct credentials before leaving your commnets"}
		end
		
	end

	def index
		
		if params["project_id"]
			
			project = Project.all.find_by(id: params["project_id"])

			project_comments = project.comments

			if project_comments
				render json: project_comments, status: 200
			else
				render json: {message: "Sorry no comments found"}
			end

		end

	end

	def show
	end

	def update
	end

	def destroy
	end

	private

  def comment_params
    params.require(:comment).permit(:title, :description, :user_id, :project_id)
  end

  def authenticate_user?
    #extract token from request header
    token = request.headers["HTTP_TOKEN"]
    
    #Use extracted token to verify user is a valid user
    decoded_user = Auth.decode_token(token)
    
    decoded_user && comment_params["user_id"] == decoded_user["id"] ? true : false
   
  end

end
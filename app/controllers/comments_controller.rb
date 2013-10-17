class CommentsController < ApplicationController
	before_filter :authenticate_user!
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params[:comment])
		@comment.user = current_user

	    respond_to do |format|
	    	if @comment.save
	    		format.html { redirect_to @post, notice: "Thanks for your comment!" }
			  	format.js { render status: :created }
			else
				format.html { redirect_to @post, flash: { error: "Error saving comment!" }}
			  	format.js { render js: "alert('Error saving comment');"}
			end
	  	end 
	end

	def vote_up
		@post = Post.find(params[:post_id])
		@vote = Vote.create()
		redirect_to @post
	end

	def vote_down
		@post = Post.find(params[:post_id])
		redirect_to @post
	end

	def mark_as_not_abusive
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])

		respond_to do |format|
			if current_user.owner?(@post) && @comment.mark_as_not_abusive!
				format.html { redirect_to @post, notice: "Comment has been marked as not abusive"}
			else
				format.html { redirect_to @post, flash: { error: "Error marking comment"}}
			end
		end
	end
end

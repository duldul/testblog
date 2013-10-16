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
end

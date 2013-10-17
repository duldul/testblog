class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :build_vote, only: [:vote_up, :vote_down]
	
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
		@vote.value = 1

		if @vote.save
			redirect_to @post, notice: "Comment has been voted"
		else
			redirect_to @post, flash: { error: "Error voting"}
		end
	end

	def vote_down
		@vote.value = -1

		if @vote.save
			redirect_to @post, notice: "Comment has been voted"
		else
			redirect_to @post, flash: { error: "Error voting"}
		end
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

	def build_vote
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@vote = @comment.votes.build(params)
		@vote.user = current_user
	end
end

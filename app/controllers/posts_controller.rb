class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts)
  expose_decorated(:post)
  expose(:tag_cloud) { Post.tags_with_weight }

  def index
  end

  def new
  end

  def edit
  end

  def update
    if post.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    post.destroy if current_user.owner? post
    render action: :index
  end

  def show
    set_comments
  end

  def mark_archived
    post.archive!
    render action: :index
  end

  def create
    post.user = current_user
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def comments
    set_comments
  end

  private

  def set_comments
    @comments = current_user.owner?(post) ? post.comments : post.comments.not_abusive
  end
end

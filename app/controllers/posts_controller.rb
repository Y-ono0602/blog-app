class PostsController < ApplicationController
  # before_action :move_to_index, except: :index
  def index
    @posts = Post.includes(:user).page(params[:page]).per(8).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    # Post.create(title: post_params[:title], text: post_params[:text])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(post_params)
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  # def move_to_index
  #   redirect_to action: :index unless user_signed_in?
  # end
  def post_params
    params.require(:post).permit(:title, :text).merge(user_id: current_user.id)
    # params.permit(:title, :text)
  end
end

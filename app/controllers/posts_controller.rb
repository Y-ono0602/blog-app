class PostsController < ApplicationController
  before_action :move_to_index, except: :index
  def index
    @posts = Post.order("id DESC").page(params[:page]).per(8)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    # Post.create(title: post_params[:title], text: post_params[:text])
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
  def post_params
    params.require(:post).permit(:title, :text)
    # params.permit(:title, :text)
  end
end

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show 
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create 
    @post = current_user.post.build(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:body,:user_id)
  end
end

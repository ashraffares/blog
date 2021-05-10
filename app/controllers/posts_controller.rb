class PostsController < ApplicationController
  before_action :authenticate_user!,except: %i[show index]
  before_action :correct_user,only: %i[edit update destroy]
  def index
    @posts = Post.all
    if user_signed_in?
      @post = current_user.posts.build
    end
  end

  def show 
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create 
    @post = current_user.posts.build(post_params)
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

  def correct_user
    @user = current_user.posts.find_by(id: params[:id])
    redirect_to root_path, notice: "Not Authorized To Edit Or Delete This Post" if @user.nil?
    puts "#########################"
    puts @user.inspect
    puts params
    puts "#########################"
  end
  private

  def post_params
    params.require(:post).permit(:title,:body,:user_id)
  end
end

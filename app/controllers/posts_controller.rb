class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def like
    Like.create(user_id: params[:data][:user_id])
    Like.update_likes_counter(params[:data][:post_id])
    redirect_to posts_show_path(params[:data][:post_id])
  end

  # GET /posts or /posts.json
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes([:comments])

    respond_to do |format|
      format.html
      format.json { render json: { posts: @posts, user: @user } }
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: { post: @post, user: @user } }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(user_id: params[:user_id], title: params[:title], text: params[:text])
    if @post.save
      redirect_to posts_path, notice: 'Create post successfully'
    else
      redirect_to posts_path, notice: 'Something went wrong Please try again!'
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end
end

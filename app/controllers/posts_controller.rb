class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :add_like
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.likes.build()
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_like
    @post = Post.find(params[:id])
    if @post
      @post.likes[0].like_count += 1

      if @post.likes[0].save
        respond_to do |format|
          format.html { redirect_to @post, notice: 'Like was successfully created.' }
          format.json { render json: { post: @post, likes: @post.likes[0].like_count }, status: :ok }
        end
      else
        format.json { render json: @post.likes[0].errors, status: :unprocessable_entity }
      end
    else
      format.json { render json: { error: 'Post not found' }, status: :not_found }
    end
  end

  def show 
    @post = Post.find(params[:id])
    render json: @post, methods: [:likes]
  end

  private

  def post_params
    params.require(:post).permit(:post, :username)
  end
end

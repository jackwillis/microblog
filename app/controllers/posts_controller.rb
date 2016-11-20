class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @posts = page(timeline_posts)
    @post = Post.new
  end

  def hashtag
    @hashtag = params[:hashtag]

    @posts = page(hashtag_posts)
    @posts_count = hashtag_posts.count
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: posts_path }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    if current_user.like(@post)
      flash[:notice] = "Liked post"
    else
      flash[:alert] = "Did not like post"
    end

    redirect_to @post
  end

  def unlike
    if current_user.unlike(@post)
      flash[:notice] = "Unliked post"
    else
      flash[:alert] = "Did not unlike post"
    end

    redirect_to @post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(token: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body)
    end

    def timeline_posts
      posts = if user_signed_in?
        Post.followed_posts_for(current_user)
      else
        Post.all
      end
      
      posts.includes(:user, :post_likes)
    end

    def hashtag_posts
      posts = Post.with_hashtag(params[:hashtag])

      posts.includes(:user, :post_likes)
    end

    def page(posts)
      posts.page(params[:page]).order(created_at: :desc)
    end
end

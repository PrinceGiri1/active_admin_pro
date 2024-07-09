class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  	@post.increment!(:read_count)
  	@comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      send_new_post_notification(@post)
      redirect_to '/', notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :user_id, :read_count, :approved_by_admin)
    end

    def send_new_post_notification(post)
      subscriptions = Subscription.all
      subscriptions.each do |subscription|
        message = "New Post Created: #{post.title}"
        PushNotificationService.new(subscription, message).send_notification
      end
    end
end

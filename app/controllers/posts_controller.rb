class PostsController < ApplicationController
  # before_action :logged_in_user, only: [:create, :destroy]
  before_action :authenticate_user!
  before_action :correct_user,   only: :destroy
  
  def new
    @post = current_user.posts.build
  end
  
  def show
    @post = Post.find(params[:id])
    @comment_list = @post.comments
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to new_post_comment_path(@post)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      if params[:post]
        params.require(:post).permit(:picture)
      end
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end

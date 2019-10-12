class CommentsController < ApplicationController
  
  def new
    @comment = current_user.comments.build
    @post = Post.find(params[:post_id])
    @comment_list = @post.comments
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end

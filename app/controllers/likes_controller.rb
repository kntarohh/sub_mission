class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    unless @post.iine?(current_user)
      @post.give_iine(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.iine?(current_user)
      @post.cancel_iine(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end

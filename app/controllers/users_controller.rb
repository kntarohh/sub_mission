class UsersController < ApplicationController
  
  before_action :admin_user,     only: :destroy
  before_action :get_user,   only: [:edit_password, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  # パスワード変更画面
  def edit_password
    
  end
  
  # パスワードを変更する
  def update_password

    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit_password'
    elsif @user.valid_password?(params[:user][:current_password]) && @user.update_attributes(user_params)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit_password'
    end
  end
  
  private
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def get_user
      @user = current_user
    end
end
 
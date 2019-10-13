class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :admin_user,     only: :destroy
  before_action :get_user,   only: [:edit_password, :update_password]
  
  # ユーザー一覧（ヘッダー）
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # ユーザー個別ページ
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
  
  def update_password
    if !check_password
      render 'edit_password'
    elsif @user.valid_password?(params[:user][:current_password]) && @user.update_attributes(user_params)
      flash[:notice] = "パスワードが変更されました"
      redirect_to new_user_session_url
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
    
    def check_password
      if params[:user][:password].empty?
        flash[:danger] = "パスワードを入力してください"
        false
      elsif params[:user][:password_confirmation].empty?
        flash[:danger] = "パスワード（確認）を入力してください"
        false
      elsif params[:user][:password] != params[:user][:password_confirmation]
        flash[:danger] = "確認に失敗しました"
        false
      elsif params[:user][:password] == params[:user][:current_password]
        flash[:danger] = "他のパスワードを入力してください"
        false
      else
        true
      end
    end
end
 
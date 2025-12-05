class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all.page(params[:page]).reverse_order
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end
  
  def edit
    @user =User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    blob = @user.profile_image.attachment&.blob
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      # もし、すでにプロフィール画像が存在する場合は、そのプロフィール画像を再利用する
      @user.profile_image.attachment.blob = blob if blob.present?
      render :edit
    end
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "不正なアクセスです。"
      redirect_to posts_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
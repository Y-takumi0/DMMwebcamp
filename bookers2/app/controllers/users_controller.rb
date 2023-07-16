class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

def edit
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to users_path
  end
    @user = User.find(params[:id])
end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
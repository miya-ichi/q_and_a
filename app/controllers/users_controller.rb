class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :admin_required
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avater, :admin, :password, :password_confirm)
  end
end

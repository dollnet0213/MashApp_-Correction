class UsersController < ApplicationController
  before_action :only_logged_in ,{only: [:login,:login_form,:create,:new,:destroy]}
  before_action :not_only_logge_in ,{only: [:edit,:update]}
  before_action :user_Authority ,{only: [:edit,:update,:destroy]} 
  def index
    @user= User.all
  end

  def show
    @user= User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      email: params[:email],
      password: params[:password],
      image_name: "unknown.jpeg",
      name: params[:name]
    )
    if @user.save
      flash[:notice]="ユーザーを登録しました"
      redirect_to("/users/login")
    else
      render("/users/new")
    end
  end
  
  def edit
    @user= User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name= params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if params[:image]
        @user.image_name = "#{@user.id}.jpg"
        image = params[:image]
        File.binwrite("public/users_image/#{@user.image_name}",image.read)
    end
    if @user.save
      flash[:notice]="ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
        render("/users/#{@user.id}/edit")
    end
  end

  def destroy
    @user= User.find_by(id: params[:id])
    @user.destroy
    flash[:notice]="ユーザーを削除しました"
    redirect_to("/users/new")
  end
  
  def login_form

  end
  
  def login
      @user=User.find_by(
        email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:notice] ="ログインしました"
        redirect_to("/users/#{@user.id}")
      else
        @error_message ="パスワードかメールアドレスが間違っています"
        @email = params[:email]
        @password = params[:password]
        render("/users/login_form")
      end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/users/login")
  end

  def user_Authority
    if @current_user.id != params[:id].to_i
      flash[:notice] ="権限がありません"
      redirect_to("/users/#{@current_user.id}")
    end 
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

end

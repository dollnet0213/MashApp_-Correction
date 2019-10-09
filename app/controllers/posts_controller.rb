class PostsController < ApplicationController
  before_action :not_only_logge_in  ,{only: [:new,:create,:edit,:update,:destroy]}

  def index
    @post = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(user_id: @current_user.id,post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      id: params[:id],
      content: params[:content],
      title: params[:title],
      user_id: @current_user.id
    )

    if params[:image]
      @post.image_name ="#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/posts_image/#{@post.image_name}",image.read)
    end
    if @post.save
        flash[:notice] ="投稿を作成しました"
        redirect_to("/posts/index")
    else
        render("/posts/new")
    end
  end

  def edit
      @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
      if @post.save
         flash[:notice] ="投稿を編集しました"
         redirect_to("/posts/index")
      else
        render("/posts/edit")
      end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def edit_authority
    @post = Post.find_by(id: params[:id])
      if @current_user.id != @post.user_id
          flash[:notice] ="権限がございません"
          redirect_to("/posts/index")
      end
  end

end

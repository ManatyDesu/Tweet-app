class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all
  end

  def article
    @post = Post.find_by(id: params[:id])
  end

  # 記事の編集画面へ移動
  def edit
    @post = Post.find_by(id: params[:id])
  end

  # 記事の削除
  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      redirect_to("/")
    else
      render("posts/edit")
    end
  end

  # 記事の編集を行い保存する
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to("/")
    else
      render("posts/edit")
    end
  end

  def new_post_form
    @current_user_id = @current_user.id
  end

  def new_post
    @post = Post.new(content: params[:content], user_id: params[:id])
    if @post.save
      redirect_to("/")
    else
      @content = params[:content]
      render("posts/new_post_form")
    end
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      redirect_to("/")
    end
  end
end


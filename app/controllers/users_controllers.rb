class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:signup_form, :create, :login_form, :login]}

  def index
    @user = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @error_message = "ログインに失敗しました"
      @email = params[:email]
      @password = params[:password]
      render 'users/login_form'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end

  def signup_form
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "inu.png"
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/")
    else
      render("users/signup_form")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.png"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      redirect_to("/users/index")
    else
      render("users/edit")
    end
  end
end

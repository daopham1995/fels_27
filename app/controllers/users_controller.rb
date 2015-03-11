class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
  end

  def new
    redirect_to root_url if logged_in?
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.admin = 0
    if @user.save
      flash[:success] = "Register success,Welcome to the Japanese Elearning System"
      redirect_to login_path
    else
      render "new"
    end
  end

  def show
    @user = User.find params[:id]
    @lessons = Lesson.where user_id: params[:id]
    @learned_words = @user.lessons.map(&:words).flatten.uniq.count
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success]= "profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :username, :email, :password,
                                   :password_confirmation
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "U dont have right to access this page.Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    if current_user.id != @user.id
      flash[:danger] = "U dont have right to access this page"
      redirect_to root_url
    end
  end
end

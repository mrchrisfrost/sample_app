

class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy 
  # The next line of code was needed to exclude actions that a signed in user could do.
  before_filter :signed_in_user_filter, only: [:new, :create]

  def signed_in_user_filter
    redirect_to root_path, notice: "You are already signed in." if signed_in?
  end 

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]) 
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit 
    #@user = User.find(params[:id])  Removed in 9.14
  end 

  def update
    #@user = User.find(params[:id])  Removed in 9.14
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updates!"
      redirect_to @user 
    else 
      render 'edit'
    end
  end 

  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end

  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to users_url
  end 

  include SessionsHelper

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end

    # Before filters

    def unsigned_in_user
      puts signed_in? 
      redirect_to root_url, notice: "You are already signed in." unless !signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin? 
    end 
end




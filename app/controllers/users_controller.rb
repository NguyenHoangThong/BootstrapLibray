class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: :destroy
  def new
  	@user=User.new
  end

  def show
    @user=User.find(params[:id])
    if @user.nil? 
      render root_url
    else
      render 'show'
    end
  end
  
 def listuser
  	@user=User.paginate(page: params[:page], per_page: 10)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
     @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome "+@user.name+" the Ebook DUT!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to list_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Confirms a logged-in user.
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
  # Confirms the correct user.
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
  # Confirms an admin user.
  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end
  


end

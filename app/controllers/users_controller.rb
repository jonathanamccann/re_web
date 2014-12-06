class UsersController < ApplicationController
  before_action :logged_in_user,      only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,        only: [:edit, :update]
  before_action :admin_user,          only: :destroy
  before_action :verify_organization, only: [:index, :show, :edit, :update,
                                             :destroy, :following, :followers]

  before_action :verify_role,         except: [:new, :create]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def new
    puts params
    puts 'TESTING'
    @user = User.new
    @user.roleable_type = params[:user][:roleable_type]
  end
  
  def create()
    @user = User.new(user_params)
    child_class = params[:user][:roleable_type].camelize.constantize
    resource = child_class.new
    @user.roleable = resource
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
    
    def user_params
      if Rails.env.development?
        params.require(:user).permit(:first_name, :last_name, :email, :password,
                                     :password_confirmation, :roleable, :organization_id)
      else
        params.require(:user).permit(:first_name, :last_name, :email, :password,
                                     :password_confirmation, :roleable)
      end
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # Confirms an organization id.
    def verify_organization
      redirect_to(new_organization_url) unless current_user.organization_id
    end

  # Verifies a user has the appropriate role
  def verify_role
    redirect_to(root_url) unless current_user.role === 'Teacher'
  end
end

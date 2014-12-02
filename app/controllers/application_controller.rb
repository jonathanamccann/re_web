class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  def render_409(message)
    render :status => :conflict, :text => message
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_400(message)
    render :status => :bad_request, :text => message
  end

  def render_200(message)
    render :status => :ok, :text => message
  end

  def current_organization
    Organization.find(current_organization_id)
  end
  helper_method :current_organization

  def current_organization_id
    if session[:organization_id].blank?
      current_organization.organization_id
    else
      session[:organization_id]
    end
  end
  helper_method :current_organization_id

  def user_is_demo
    current_organization_id == organization.demo_id
  end
end

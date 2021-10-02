class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :admin_login?
  before_action :login_required
  before_action :admin_required

  private

  def current_user
    @current_user || User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def admin_login?
    current_user&.admin? && session[:admin] == true
  end

  def login_required
    unless current_user
      flash[:error] = 'ログインが必要です。'
      redirect_to login_url
    end
  end

  def admin_required
    unless admin_login?
      redirect_to root_url
    end
  end
end

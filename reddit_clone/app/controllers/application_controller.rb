class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end
  
  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user = User.find_by(session_token: session[:session_token])
  end
  
  def require_login
    redirect_to new_session_url unless logged_in?
  end
  
  def ensure_moderator
    @sub = Sub.find(params[:id])
    unless is_moderator?
      flash[:errors] = ['YOU ARE NOT A MOD']
      redirect_to sub_url(@sub)
    end
  end
  
  def is_moderator?
    @sub = Sub.find(params[:id])
    current_user == @sub.moderator
  end
    
  
end

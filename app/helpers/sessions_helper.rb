module SessionsHelper
  def log_in(user)
    reset_session
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end

  def current_user_admin?
    return false unless logged_in?

    !current_user.roles.find_by(name: :admin).nil?
  end

  def set_temp_book_url(url)
    session[:book_url] = url 
  end

  def get_temp_book_url
    session.delete(:book_url)
  end
end

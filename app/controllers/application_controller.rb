class ApplicationController < ActionController::Base
  include SessionsHelper
  def main_page
    if logged_in?
      redirect_to home_path
    else
      redirect_to login_path
    end
  end
end

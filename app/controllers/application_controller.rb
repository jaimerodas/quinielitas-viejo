class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url
    end
  end

  def set_match_pool
    @match_pool = MatchPool.find(params[:match_pool_id])
  end
end

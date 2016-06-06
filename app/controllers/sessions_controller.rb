class SessionsController < ApplicationController
  layout 'session'

  def new
    redirect_to root_path and return if logged_in?
  end

  def oauth
    redirect_to root_path and return if logged_in?

    user = User.find_by(auth_hash)
    puts "#{user.inspect}"
    user = User.create(auth_create_hash) unless user

    init_session_for user
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Sesión cerrada exitosamente"
    redirect_to login_path
  end

  private

  def init_session_for user
    log_in user
    remember user
    redirect_back_or root_path
  end

  def auth_hash
    return {
      uid: request.env['omniauth.auth'].uid,
      provider: request.env['omniauth.auth'].provider
    }
  end

  def auth_create_hash
    {
      uid: request.env['omniauth.auth'].uid,
      provider: request.env['omniauth.auth'].provider,
      name: request.env['omniauth.auth'].info.name,
      email: request.env['omniauth.auth'].info.email,
      auth_token: request.env['omniauth.auth'].credentials.token
    }
  end
end

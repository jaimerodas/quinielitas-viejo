class SessionsController < ApplicationController
  layout 'session'

  def new
    redirect_to root_path and return if logged_in?
  end

  def create
    redirect_to root_path and return if logged_in?

    user = User.find_by(email_token: params[:token])
    if user
      user.update_attribute(:email_token, nil)
      init_session_for user
    else
      flash.now[:danger] = "Esa liga no es válida"
      render 'new'
    end
  end

  def email
    user = User.find_by(email: params[:session][:email].downcase)

    if user
      user.authenticate!
      redirect_to success_path
    else
      flash.now[:danger] = "No existe esa cuenta"
      render 'new'
    end
  end

  def oauth
    redirect_to root_path and return if logged_in?

    user = User.find_by(auth_hash)

    if user
      user.update(auth_update_hash)
    else
      user = User.create(auth_create_hash)
    end

    init_session_for user
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Sesión cerrada exitosamente"
    redirect_to login_path
  end

  def success
  end

  private

  def init_session_for user
    log_in user
    remember user
    redirect_back_or root_path
  end

  def auth_hash
    return {
      email: request.env['omniauth.auth'].info.email,
    }
  end

  def auth_update_hash
    {
      uid: request.env['omniauth.auth'].uid,
      provider: request.env['omniauth.auth'].provider,
      auth_token: request.env['omniauth.auth'].credentials.token
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

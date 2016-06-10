class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(created_at: :desc)
  end

  # GET /users/new
  def new
    redirect_to root_path and return if logged_in?

    @user = User.new
    render layout: 'session'
  end

  # GET /users/1/edit
  def edit
    @url = user_path(@user)
    @url = profile_path unless params[:id]
  end

  # POST /users
  # POST /users.json
  def create
    redirect_to root_path and return if logged_in?

    @user = User.new(user_params)

      if @user.save
        @user.authenticate!
        redirect_to success_path
      else
        render :new, layout: 'session'
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      redirect = users_path
      redirect = root_path unless params[:id]

      if @user.update(user_params)
        format.html { redirect_to redirect, notice: 'El usuario fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        @url = user_path(@user)
        @url = profile_path unless params[:id]

        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:id]
        @user = User.find(params[:id])
      else
        @user = current_user
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :admin)
    end
end

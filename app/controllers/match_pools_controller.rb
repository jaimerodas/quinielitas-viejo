class MatchPoolsController < ApplicationController
  before_action :logged_in_user

  def index
    @match_pools = MatchPool.all.order(created_at: :asc)
  end

  def show
    @match_pool = MatchPool.find(params[:id])
  end

  def new
    @match_pool = MatchPool.new
  end

  def create
    @match_pool = MatchPool.new(match_pool_params)

    if @match_pool.save
      redirect_to match_pool_matches_path(@match_pool)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def match_pool_params
    params.require(:match_pool).permit(:name)
  end
end

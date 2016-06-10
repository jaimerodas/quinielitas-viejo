class MatchPoolsController < ApplicationController
  before_action :logged_in_user
  before_action :set_match_pool, only: [:show, :advance, :score]

  def index
    @match_pools = MatchPool.all.order(created_at: :asc)
  end

  def show
    get_scoreboard
    @matches = matches_with_bets_for(current_user)
  end

  def new
    @match_pool = MatchPool.new
  end

  def create
    @match_pool = MatchPool.new(match_pool_params)

    if @match_pool.save
      redirect_to match_pool_path(@match_pool)
    else
      render 'new'
    end
  end

  def advance
    @match_pool.open_betting! unless @match_pool.bets_opened_at
    redirect_to @match_pool
  end

  def score
    redirect_to @match_pool and return unless @match_pool.bets_closed_at

    matches = @match_pool.matches.where('matches.home IS NOT NULL').where('matches.away IS NOT NULL')

    matches.each do |match|
      match.bets.each do |bet|
        bet.score!(match.home, match.away)
      end
    end

    flash[:success] = 'Puntajes recalculados'
    redirect_to @match_pool
  end

  private

  def set_match_pool
    @match_pool = MatchPool.find(params[:id])
  end

  def match_pool_params
    params.require(:match_pool).permit(:name)
  end
end

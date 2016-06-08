class MatchPoolsController < ApplicationController
  before_action :logged_in_user
  before_action :set_match_pool, only: [:show, :advance, :score]

  def index
    @match_pools = MatchPool.all.order(created_at: :asc)
  end

  def show
    if current_user.bets_for(@match_pool).count > 0
      @matches = Match.select('
        matches.id,
        matches.home_team_id,
        matches.away_team_id,
        matches.when,
        matches.home,
        matches.away,
        bets.home user_home,
        bets.away user_away,
        bets.points user_points
      ').joins('JOIN bets ON bets.match_id = matches.id')
      .where(match_pool: @match_pool).where('bets.user_id = ?', current_user.id)
      .order(when: :asc)
    else
      @matches = @match_pool.matches.order(when: :asc)
    end
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

  def edit
  end

  def update
  end

  def destroy
  end

  def advance
    if @match_pool.accepts_matches?
      @match_pool.open_betting!
    else
      @match_pool.close_betting!
    end

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

class BetsController < ApplicationController
  before_action :logged_in_user
  before_action :set_match_pool

  def show
    @user = User.find(params[:id])
    get_scoreboard
    @matches = matches_with_bets_for(@user)
  end

  def create
    if current_user.bets_for(@match_pool).empty?
      @matches = @match_pool.matches.order(when: :asc)

      @matches.each do |m|
        Bet.create(
          user: current_user,
          match: m,
          match_pool: @match_pool
        )
      end
    end

    redirect_to edit_match_pool_bets_path(@match_pool)
  end

  def edit
    @bets = current_user.bets_available_for(@match_pool)
  end

  def update
    @bets = Bet.update(params[:bets].keys, params[:bets].values)
    @bets.each do |b|
      if b.errors.any?
        puts 'error'
        render 'edit'
        return
      end
    end

    redirect_to match_pool_path(@match_pool)
  end
end

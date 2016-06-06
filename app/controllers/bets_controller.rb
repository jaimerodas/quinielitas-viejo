class BetsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def show
  end

  def create
    if current_user.bets.empty?
      @matches = Match.all.order(when: :asc)

      @matches.each do |m|
        Bet.create(
          user: current_user,
          match: m
        )
      end
    end

    redirect_to edit_bets_path
  end

  def edit
    @bets = current_user.bets
  end

  def update
    @bets = Bet.update(params[:bets].keys, params[:bets].values)
    render 'edit'
  end
end

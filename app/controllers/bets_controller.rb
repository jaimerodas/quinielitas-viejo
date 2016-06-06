class BetsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def show
  end

  def create
    if current_user.bets.empty?
      @matches = Match.all

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
  end
end

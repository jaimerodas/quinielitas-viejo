class MatchesController < ApplicationController
  before_action :logged_in_user

  before_action :set_match_pool
  before_action :only_if_open, only: [:destroy]
  before_action :set_match, only: [:edit, :update, :destroy]
  before_action :set_teams, only: [:new, :create, :edit, :update]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all.order(when: :asc)
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  def show
    @match = Match.select('
      matches.id,
      matches.home,
      matches.away,
      matches.when,
      matches.home_team_id,
      matches.away_team_id,
      home.name home_team_name,
      away.name away_team_name')
      .joins('JOIN teams home ON matches.home_team_id = home.id')
      .joins('JOIN teams away ON matches.away_team_id = away.id')
      .where('matches.id = ?', params[:id]).first

    if Time.now > @match.when
      @bets = @match.bets.order(updated_at: :desc)
    else
      @bets = @match.bets.where('user_id = ?', current_user.id)
    end
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = @match_pool_id.matches.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to matches_url, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        @match.score! if @match_pool.bets_opened_at && @match.when < Time.now

        format.html { redirect_to @match_pool, notice: 'Partido Actualizado' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    def set_teams
      @teams = Team.all.order(name: :asc)
    end

    def only_if_open
      if @match_pool.bets_opened_at
        flash[:danger] = "Acción no permitida"
        redirect_to match_pool_path(@match_pool)
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:home, :away, :when, :home_team_id, :away_team_id)
    end
end

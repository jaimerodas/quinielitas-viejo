class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :match_pool

  has_many :bets

  # No puede haber un partido con el mismo equipo de local y visitante
  validate :has_different_teams

  # No pueden jugar dos partidos al mismo tiempo
  validate :teams_have_no_matches_at_that_time, on: :create
  validate :teams_have_no_other_matches_at_that_time, on: :update
  validate :match_pool_accepts_matches

  def month
    I18n.l self.when, format: :month
  end

  def date
    I18n.l self.when, format: :date
  end

  def time
    I18n.l self.when, format: :short_time
  end

  def score!
    self.bets.each {|b| b.score! self.home, self.away } unless self.home.nil? or self.away.nil?
  end

  def number_of_bets
    self.bets.where('home is not null').where('away is not null').count
  end

  def win_proportion
    win = self.bets.where('bets.home > bets.away').count
    return ((win.to_f / self.number_of_bets) * 100).round unless self.number_of_bets == 0
    return 0
  end

  def lose_proportion
    lose = self.bets.where('bets.home < bets.away').count
    return ((lose.to_f / self.number_of_bets) * 100).round unless self.number_of_bets == 0
    return 0
  end

  def draw_proportion
    draw = self.bets.where('bets.home = bets.away').count
    return ((draw.to_f / self.number_of_bets) * 100).round unless self.number_of_bets == 0
    return 0
  end

  private

  def has_different_teams
    errors.add(:home_team, "no puede ser el mismo equipo que el visitante") if home_team_id == away_team_id
  end

  def teams_have_no_matches_at_that_time
    team_has_no_matches :home_team_id
    team_has_no_matches :away_team_id
  end

  def teams_have_no_other_matches_at_that_time
    team_has_no_matches :home_team_id, id
    team_has_no_matches :away_team_id, id
  end

  def team_has_no_matches team, id=false
    matches = self.class.where('home_team_id = ? or away_team_id = ? ', self.send(team), self.send(team)).where(when: self.when)
    matches = matches.where('id != ?', id) if id
    errors.add(team, "ya tiene un juego en ese momento") if matches.size > 0
  end

  def match_pool_accepts_matches
    errors.add(:base, 'no se puede editar en este momento') unless (!self.match_pool.bets_opened_at || self.when < Time.now)
  end
end

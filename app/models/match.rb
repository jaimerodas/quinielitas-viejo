class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  # No puede haber un partido con el mismo equipo de local y visitante
  validate :has_different_teams

  # No pueden jugar dos partidos al mismo tiempo
  validate :teams_have_no_matches_at_that_time, on: :create

  private

  def has_different_teams
    errors.add(:home_team, "no puede ser el mismo equipo que el visitante") if home_team_id == away_team_id
  end

  def teams_have_no_matches_at_that_time
    local = self.class.where(
      'home_team_id = ? or away_team_id = ? ',
      home_team_id,
      home_team_id
    ).where(when: self.when)
    visit = self.class.where(
      'home_team_id = ? or away_team_id = ? ',
      away_team_id,
      away_team_id
    ).where(when: self.when)

    errors.add(:home_team_id, "ya tiene un juego en ese momento") if local.size > 0
    errors.add(:away_team_id, "ya tiene un juego en ese momento") if visit.size > 0
  end
end

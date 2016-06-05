class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  # No puede haber un partido con el mismo equipo de local y visitante
  validate :has_different_teams

  # No pueden jugar dos partidos al mismo tiempo
  validate :teams_have_no_matches_at_that_time, on: :create
  validate :teams_have_no_other_matches_at_that_time, on: :update

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
end

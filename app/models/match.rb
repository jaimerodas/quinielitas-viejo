class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  validate :has_different_teams

  private

  def has_different_teams
    errors.add(:home_team, "no puede ser el mismo equipo que el visitante") if home_team_id == away_team_id
  end
end

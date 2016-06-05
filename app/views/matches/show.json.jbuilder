json.home_team do
  json.name @match.home_team.name
  json.id @match.home_team_id
end

json.away_team do
  json.name @match.away_team.name
  json.id @match.away_team_id
end

json.(@match, :home, :away, :when, :created_at, :updated_at)

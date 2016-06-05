json.array!(@matches) do |match|
  json.home_team match.home_team.name
  json.away_team match.away_team.name

  json.extract! match, :id, :home, :away, :when
  json.url match_url(match, format: :json)
end

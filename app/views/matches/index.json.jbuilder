json.array!(@matches) do |match|
  json.extract! match, :id, :home, :away, :when
  json.url match_url(match, format: :json)
end

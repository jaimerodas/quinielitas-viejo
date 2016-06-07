# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

teams = [
  'Francia', 'Rumania', 'Albania', 'Suiza', # Grupo A
  'Gales', 'Eslovaquia', 'Inglaterra', 'Rusia', # Grupo B
  'Polonia', 'Irlanda del Norte', 'Alemania', 'Ucrania', # Grupo C
  'Croacia', 'Turquía', 'España', 'República Checa', # Grupo D
  'Irlanda', 'Suecia', 'Bélgica', 'Italia', # Grupo E
  'Austria', 'Hungría', 'Portugal', 'Islandia' # Grupo F
]

teams.each do |t|
  Team.create(name: t)
end

quiniela = MatchPool.create(name: 'Eurocopa 2016')

quiniela.matches.create [
  {home_team_id: 1, away_team_id: 2, when: Time.new(2016, 06, 10, 11, 00, 00, '-05:00')},
  {home_team_id: 3, away_team_id: 4, when: Time.new(2016, 06, 11, 13, 45, 00, '-05:00')},
  {home_team_id: 2, away_team_id: 4, when: Time.new(2016, 06, 15, 11, 00, 00, '-05:00')},
  {home_team_id: 1, away_team_id: 3, when: Time.new(2016, 06, 15, 13, 45, 00, '-05:00')},
  {home_team_id: 2, away_team_id: 3, when: Time.new(2016, 06, 19, 13, 45, 00, '-05:00')},
  {home_team_id: 4, away_team_id: 1, when: Time.new(2016, 06, 19, 13, 45, 00, '-05:00')},

  {home_team_id: 5, away_team_id: 6, when: Time.new(2016, 06, 11, 11, 00, 00, '-05:00')},
  {home_team_id: 7, away_team_id: 8, when: Time.new(2016, 06, 11, 13, 45, 00, '-05:00')},
  {home_team_id: 8, away_team_id: 6, when: Time.new(2016, 06, 15, 11, 00, 00, '-05:00')},
  {home_team_id: 7, away_team_id: 5, when: Time.new(2016, 06, 16, 13, 45, 00, '-05:00')},
  {home_team_id: 8, away_team_id: 5, when: Time.new(2016, 06, 20, 13, 45, 00, '-05:00')},
  {home_team_id: 6, away_team_id: 7, when: Time.new(2016, 06, 20, 13, 45, 00, '-05:00')},

  {home_team_id: 9, away_team_id: 10, when: Time.new(2016, 06, 12, 11, 00, 00, '-05:00')},
  {home_team_id: 11, away_team_id: 12, when: Time.new(2016, 06, 12, 13, 45, 00, '-05:00')},
  {home_team_id: 12, away_team_id: 10, when: Time.new(2016, 06, 16, 11, 00, 00, '-05:00')},
  {home_team_id: 11, away_team_id: 9, when: Time.new(2016, 06, 16, 13, 45, 00, '-05:00')},
  {home_team_id: 12, away_team_id: 9, when: Time.new(2016, 06, 21, 13, 45, 00, '-05:00')},
  {home_team_id: 10, away_team_id: 11, when: Time.new(2016, 06, 21, 13, 45, 00, '-05:00')},

  {home_team_id: 13, away_team_id: 14, when: Time.new(2016, 06, 12, 11, 00, 00, '-05:00')},
  {home_team_id: 15, away_team_id: 16, when: Time.new(2016, 06, 13, 13, 45, 00, '-05:00')},
  {home_team_id: 16, away_team_id: 13, when: Time.new(2016, 06, 17, 11, 00, 00, '-05:00')},
  {home_team_id: 15, away_team_id: 14, when: Time.new(2016, 06, 17, 13, 45, 00, '-05:00')},
  {home_team_id: 16, away_team_id: 14, when: Time.new(2016, 06, 21, 13, 45, 00, '-05:00')},
  {home_team_id: 13, away_team_id: 15, when: Time.new(2016, 06, 21, 13, 45, 00, '-05:00')},

  {home_team_id: 17, away_team_id: 18, when: Time.new(2016, 06, 13, 11, 00, 00, '-05:00')},
  {home_team_id: 19, away_team_id: 20, when: Time.new(2016, 06, 13, 13, 45, 00, '-05:00')},
  {home_team_id: 20, away_team_id: 18, when: Time.new(2016, 06, 17, 11, 00, 00, '-05:00')},
  {home_team_id: 19, away_team_id: 17, when: Time.new(2016, 06, 18, 13, 45, 00, '-05:00')},
  {home_team_id: 20, away_team_id: 17, when: Time.new(2016, 06, 22, 13, 45, 00, '-05:00')},
  {home_team_id: 18, away_team_id: 19, when: Time.new(2016, 06, 22, 13, 45, 00, '-05:00')},

  {home_team_id: 21, away_team_id: 22, when: Time.new(2016, 06, 14, 11, 00, 00, '-05:00')},
  {home_team_id: 23, away_team_id: 24, when: Time.new(2016, 06, 14, 13, 45, 00, '-05:00')},
  {home_team_id: 24, away_team_id: 22, when: Time.new(2016, 06, 18, 11, 00, 00, '-05:00')},
  {home_team_id: 23, away_team_id: 21, when: Time.new(2016, 06, 18, 13, 45, 00, '-05:00')},
  {home_team_id: 24, away_team_id: 21, when: Time.new(2016, 06, 22, 13, 45, 00, '-05:00')},
  {home_team_id: 22, away_team_id: 23, when: Time.new(2016, 06, 22, 13, 45, 00, '-05:00')}
]

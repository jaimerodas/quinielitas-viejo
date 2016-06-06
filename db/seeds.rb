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

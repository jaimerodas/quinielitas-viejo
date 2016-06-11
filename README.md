# Quinielitas

Quinielitas es una pequeña aplicación de Rails para poder llevar registro de quinielas. Sirvió para
aprender a usar Rails 5, aunque por ahora no uso cosas como actioncable (eso podría cambiar si es
que consigo suficiente tiempo). A continuación, una resumen de qué necesitas para correr esto tú.

## Entorno

### rbenv
Uso rbenv porque rvm tiene muchas cosas que no uso. Este app usa ruby 2.3.0, pero chance y funciona
con versiones anteriores.

### rails 5
Por ahora esto tiene Rails 5.0.0rc1, porque era la última versión al momento de iniciar el proyecto.

### postgresql
Llevo mucho tiempo jugando en MongoDB y quería regresar a usar SQL. Resultó que postgres es la onda;
tiene funciones muy chidas y juega muy bien con Rails.

## Configuración
Necesitas 5 archivos de configuración, por lo menos, los cuales están ignorados por el git, pero
existen copias con `.example.ext`. Los archivos son:

- `config/database.yml`
- `config/facebook.yml`
- `config/mail.yml`
- `config/nginx.conf`

Además, uso [Primaries][1] de los increíbles diseñadores de [Parakeet][2]. Yo uso las versiones en
svg, y el método `icon` en el `application_helper` los inserta en el html.

## Deployment
- Capistrano


[1]: http://parakeet.co
[2]: http://parakeet.co/primaries

# Quinielitas

Quinielitas es una pequeña aplicación de Rails para poder llevar registro de quinielas. Sirvió para
aprender a usar Rails 5, aunque por ahora no uso cosas como actioncable (eso podría cambiar si es
que consigo suficiente tiempo). A continuación, una resumen de qué necesitas para correr esto tú.

Una de las ideas principales de esto era que nadie tuviera que guardar contraseñas, por lo que hay
dos maneras de hacer login: o con facebook, o a través de un one-time-link que se manda a tu correo.

## Entorno

### rbenv
Uso rbenv porque rvm tiene muchas cosas que no uso. Este app usa ruby `2.3.0`, pero chance y funciona
con versiones anteriores.

### rails 5
Por ahora esto tiene Rails 5.0.0rc1, porque era la última versión al momento de iniciar el proyecto.

### postgresql
Llevo mucho tiempo jugando en MongoDB y quería regresar a usar SQL. Resultó que postgres es la onda;
tiene funciones muy chidas y juega muy bien con Rails.

### Facebook
Puedes hacer un app de facebook en dos patadas. Usando la configuración default (este app sólo pide
email), no necesitas pasar por ningún proceso de aprobación ni nada. Entra a [Facebook Developers][3]
y ve qué onda.

### Mailgun
Mandar correos con [estos cuates][4] es bien fácil. Sólo te das de alta y puedes mandar hasta 10,000
correos gratis al mes. Nosotros usamos un custom domain, track opens y nunca hemos pagado un peso.

## Configuración
Necesitas 5 archivos de configuración, por lo menos, los cuales están ignorados por el git, pero
existen copias con `.example.ext`. Los archivos son:

- [config/database.yml][local-1] contraseñas de postgres
- [config/facebook.yml][local-2] detalles del app de facebook
- [config/mail.yml][local-3] contraseñas de mailgun
- [config/secrets.yml][local-4] los secrets que usa rails
- [config/nginx.conf][local-5] configuracion de nginx para deploy

Además, uso [Primaries][1] de los increíbles diseñadores de [Parakeet][2]. Yo uso las versiones en
svg, y el método `icon` en el `application_helper` los inserta en el html.

## Deployment

### Capistrano
Porque es bonito. Revisa la configuración en [deploy.rb][local-6]. Sí lo usas, todo se deployea con
`cap production deploy`.

### Nginx y LetsEncrypt
Como el mundo es más bonito con encripción, y ya no cuesta un peso sacar certificados SSL, puedes
encriptar tu dominio con [LetsEncrypt][5]. Yo tengo mi cheatsheet de como automatizarlo [aquí][6].
Además, así puedes usar mi `nginx.conf` sin ningún problema.


[1]: http://parakeet.co
[2]: http://parakeet.co/primaries
[3]: https://developers.facebook.com
[4]: https://mailgun.com
[5]: https://letsencrypt.org
[6]: https://gist.github.com/jaimerodas/1fa36c2d6926915f4f25f30cdfa071b5

[local-1]: /config/database.example.yml
[local-2]: /config/facebook.example.yml
[local-3]: /config/mail.example.yml
[local-4]: /config/secrets.example.yml
[local-5]: /config/nginx.example.conf
[local-6]: /config/deploy.rb

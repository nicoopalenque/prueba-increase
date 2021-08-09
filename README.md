# Instalacion

Clonar repositorio

`$ git clone https://github.com/nicoopalenque/prueba-increase.git`

Ir al repositorio clonado

`$ cd prueba-increase`

Instalar gemas

`$ bundle install`

Iniciar aplicacion

`$ rails s`

Correr sidekiq para traer datos desde la fuente cada 10 minutos

`$ bundle exec sidekiq`

# Uso

Con postman puede hacer las siguientes consultas.
Tanto id_header y id_client se los obtiene desde el primer endpoint (/api/v1/transaction/)

* GET /api/v1/transaction/

* GET /api/v1/transaction/:id_header

* GET /api/v1/client/:id_client

# Doc
[Prueba - Increase](https://docs.google.com/document/d/1QlrhIM07YZqd1kpEg4Y1aD8vjQzLF6AQMIG59LMXIY8/edit?usp=sharing)

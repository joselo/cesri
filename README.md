# Cesri

Cesri es una Gema Ruby que permite consumir los servicios Web de Comprobantes Electrónicos del Servicio de Rentas Internas, para fines de la facturación electrónica en Ecuador.

Esta versión soporta únicamente la nueva modalidad "OFFLINE" del SRI.

## Instalación

Agregar esta linea al archivo Gemfile de la aplicación:

```ruby
gem 'cesri'
```

Luego ejecutar:

    $ bundle

O instalar la gema manualmente:

    $ gem install cesri

## Instalar

    $ rails generate cesri:install

## Configuración
Para configurar se puede sobreescribir los valores por defecto en:  `config/initializers/cesri.rb`, esto por lo general no sera necesario a menos que las URL's de los servicios web que del SRI cambien por algún motivo.

Por defecto esta gema funciona bajo el ambiente de pruebas, para cambiar a un ambiente de producción es necesario cambiar la variable `config.sandbox` a `false,` en el archivo `config/initializers/cesri.rb` de tal manera que:

```ruby
Cesri.configure do |config|
  #...
  config.sandbox = false
end
```

## Como se usa

Para usar esta Gema existen 2 clases importantes:

```
# Clase para la recepción de comprobantes
Cesri::RecepcionComprobanteService

# Clase para la autorización de comprobantes
Cesri::AutorizacionComprobanteService
```

### Recepción de comprobantes

```ruby
recepcion = Cesri::RecepcionComprobanteService.validar(xml_plano_firmado)
=> true
```

```ruby
puts recepcion.success?
=> true

puts recepcion.state
=> "RECIBIDA" 
```

En caso de que el comprobante no haya sido validado

```ruby
puts recepcion.success?
=> false

puts recepcion.state
=> "DEVUELTA" 
```
Mostrar los mensajes

```ruby
recepcion.messages.each do |m|
  puts m.identificador
  puts m.mensaje
  puts m.tipo
end
```
```
45
ERROR SECUENCIAL REGISTRADO
ERROR
```

### Autorización de comprobantes

```ruby
autorizacion = Cesri::AutorizacionComprobanteService.autorizar(clave_de_acceso)
```

```ruby
puts autorizacion.success?
=> true 

puts autorizacion.state
=> "AUTORIZADO" 
```

En caso de que el comprobante no haya sido autorizado

```ruby
puts autorizacion.success?
=> false

puts autorizacion.state
=> "NO AUTORIZADO" 
```

Mostrar los mensajes

```ruby
autorizacion.messages.each do |m|
  puts m.identificador
  puts m.mensaje
  puts m.informacion_adicional
  puts m.tipo
end
```
``` 
39
FIRMA INVALIDA
La firma es invalida [Firma inválida (firma y/o certificados alterados)]
ERROR
```

## Licencia

Cesri es software libre, y puede ser redistribuido bajo los términos especificados en el archivo de licencia. [`LICENSE`] file.

[`LICENSE`]: /LICENSE

## Para contribuir

1. Fork it ( https://github.com/joselo/cesri/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


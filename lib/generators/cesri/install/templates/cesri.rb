Cesri.configure do |config|

  # Todas las variables de abajo están comentadas, sus valores por defecto son los indicados, en caso de
  # que cambien, es suficiente con descomentar la variable y colocar el valor deseado.
  # Por defecto se usa las URL's de ambiente de pruebas, para cambiar a usar las URL's de producción
  # descomentar config.sandbox, de tal manera que sea igual a false, esto hará que las recepcioines y
  # autorizaciones se realicen en ambiente de producción.

  # URL de recepción de comprobantes en ambiente de pruebas
  #config.sandbox_reception_url = 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl'

  # URL de autorización de comprobantes en ambiente de pruebas.
  #config.sandbox_authorization_url = 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl'

  # URL de recepción de comprobantes en ambiente de producción
  #config.recepcion_url = ''

  # URL de autorización de comprobantes en ambiente de producción
  #config.authorization_url = ''

  # Por defecto es true, especifíca si esta en un ambiente de pruebas o no, para producción colocar config.sandbox = false
  #config.sandbox = true
end
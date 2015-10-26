module Cesri
  class ResponseMessage

    attr_reader :identificador
    attr_reader :mensaje
    attr_reader :informacion_adicional
    attr_reader :tipo

    def initialize(message)
      @identificador = identificador_value(message)
      @mensaje = mensaje_value(message)
      @informacion_adicional = informacion_adicional_value(message)
      @tipo = tipo_value(message)
    end

    private

    def identificador_value(message)
      message.xpath('identificador').first.content if message.xpath('identificador').first
    end

    def mensaje_value(message)
      message.xpath('mensaje').first.content if message.xpath('mensaje').first
    end

    def informacion_adicional_value(message)
      message.xpath('informacionAdicional').first.content if message.xpath('informacionAdicional').first
    end

    def tipo_value(message)
      message.xpath('tipo').first.content if message.xpath('tipo').first
    end

  end
end
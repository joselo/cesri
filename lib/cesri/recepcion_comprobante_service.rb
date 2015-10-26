module Cesri
  class RecepcionComprobanteService

    def initialize
      @client = Savon.client wsdl: request_url, ssl_verify_mode: :none
    end

    def validar(xml_raw)
      service_response = validar_comprobante(xml_raw)
      RecepcionComprobanteResponse.new(service_response)
    end

    def validar_comprobante(xml_raw)
      @client.call :validar_comprobante, validar_comprobante_request(xml_raw)
    end

    def validar_comprobante_request(xml_raw)
      {
        soap_action: false,
        message: { 
          xml: Base64.encode64(xml_raw)
        }
      }
    end

    def request_url
      if Cesri.configuration.sandbox
        Cesri.configuration.sandbox_reception_url
      else
        Cesri.configuration.recepcion_url
      end
    end

  end
end
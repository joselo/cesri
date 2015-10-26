module Cesri
  class AutorizacionComprobanteService

    def initialize
      @client = Savon.client wsdl: request_url, ssl_verify_mode: :none
    end

    def autorizar(clave_acceso)
      service_response = autorizacion_comprobante(clave_acceso)
      AutorizacionComprobanteResponse.new(service_response)
    end

    def autorizacion_comprobante(clave_acceso)
      @client.call :autorizacion_comprobante, autorizacion_comprobante_request(clave_acceso)
    end

    def autorizacion_comprobante_request(clave_acceso)
      {
        soap_action: false,
        message: { 
          clave_acceso_comprobante: clave_acceso
        }
      }
    end

    def request_url
      if Cesri.configuration.sandbox
        Cesri.configuration.sandbox_authorization_url
      else
        Cesri.configuration.authorization_url
      end
    end

  end
end
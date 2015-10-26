module Cesri

  class Configuration
    attr_accessor :sandbox_reception_url
    attr_accessor :sandbox_authorization_url
    attr_accessor :recepcion_url
    attr_accessor :authorization_url
    attr_accessor :sandbox

    def initialize
      @sandbox_reception_url = 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl'
      @sandbox_authorization_url = 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl'
      @recepcion_url = 'TODO'
      @authorization_url = 'TODO'
      @sandbox = true
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configuration=(config)
      @configuration = config
    end

    def self.configure
      yield configuration if block_given?
    end

  end

end
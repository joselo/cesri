require "cesri/version"
require "cesri/configuration"
require "cesri/autorizacion_comprobante_response"
require "cesri/recepcion_comprobante_response"
require "cesri/autorizacion_comprobante_service"
require "cesri/recepcion_comprobante_service"
require "cesri/response_message"
require "savon"
require "nokogiri"

module Cesri

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end


end
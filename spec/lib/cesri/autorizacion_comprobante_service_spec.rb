require 'spec_helper'

describe Cesri::AutorizacionComprobanteService do

  include Savon::SpecHelper

  let(:xml_response){ File.read(File.join('spec', 'fixtures', 'autorizacion_comprobante_response.xml')) }
  let(:xml_response_error){ File.read(File.join('spec', 'fixtures', 'autorizacion_comprobante_response_error.xml')) }
  let(:clave_acceso){ '1510201501110367180400110000080000000080754713012' }
  let(:request) do
    {
      soap_action: false,
      message: { 
        clave_acceso_comprobante: clave_acceso
      }
    }
  end

  before do
    load_default_config
    savon.mock!
    @service = Cesri::AutorizacionComprobanteService.new
    @request = @service.autorizacion_comprobante_request(clave_acceso)
  end

  after do
    restore_default_config
    savon.unmock!
  end

  describe '#autorizar' do
    context 'success' do
      before do
        savon.expects(:autorizacion_comprobante).with(@request).returns(xml_response)
        @response = @service.autorizar(clave_acceso)
      end

      it 'returns a AutorizacionComprobanteResponse instance' do
        expect(@response).to be_instance_of(Cesri::AutorizacionComprobanteResponse)
      end
    end

    context 'error' do
      before do
        savon.expects(:autorizacion_comprobante).with(@request).returns(xml_response_error)
        @response = @service.autorizar(clave_acceso)        
      end

      it 'returns a AutorizacionComprobanteResponse instance' do
        expect(@response).to be_instance_of(Cesri::AutorizacionComprobanteResponse)
      end
    end
  end

  describe '#autorizacion_comprobante' do
    it 'validate the clave_acceso with the service' do
      savon.expects(:autorizacion_comprobante).with(@request).returns(xml_response)
      response = @service.autorizacion_comprobante(clave_acceso)
      expect(response).to be_successful
    end
  end

  describe '#autorizacion_comprobante_request' do
    it 'create a hash with the request' do
      expect(@service.autorizacion_comprobante_request(clave_acceso)).to eq(request)
    end
  end

  describe '#request_url' do
    it 'get the sandbox request url from the configuration' do
      expect(@service.request_url).to eq(Cesri.configuration.sandbox_authorization_url)
    end

    it 'get the production request url from the configuration' do
      Cesri.configure do |config|
        config.sandbox = false
      end

      expect(@service.request_url).to eq(Cesri.configuration.authorization_url)
    end
  end

end
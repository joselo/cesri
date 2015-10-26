require 'spec_helper'

describe Cesri::RecepcionComprobanteService do

  include Savon::SpecHelper

  let(:xml_response){ File.read(File.join('spec', 'fixtures', 'validar_comprobante_response.xml')) }
  let(:xml_response_error){ File.read(File.join('spec', 'fixtures', 'validar_comprobante_response_error.xml')) }
  let(:xml_raw){ '<xml />' }
  let(:request) do
    {
      soap_action: false,
      message: { 
        xml: Base64.encode64(xml_raw)
      }
    }
  end

  before do
    load_default_config
    savon.mock!
    @service = Cesri::RecepcionComprobanteService.new
    @request = @service.validar_comprobante_request(xml_raw)
  end

  after do
    restore_default_config
    savon.unmock!
  end

  describe '#validar' do
    context 'success' do
      before do
        savon.expects(:validar_comprobante).with(@request).returns(xml_response)
        @response = @service.validar(xml_raw)
      end

      it 'returns a RecepcionComprobanteResponse instance' do
        expect(@response).to be_instance_of(Cesri::RecepcionComprobanteResponse)
      end
    end

    context 'error' do
      before do
        savon.expects(:validar_comprobante).with(@request).returns(xml_response_error)
        @response = @service.validar(xml_raw)
      end

      it 'returns a RecepcionComprobanteResponse instance' do
        expect(@response).to be_instance_of(Cesri::RecepcionComprobanteResponse)
      end
    end
  end

  describe '#validar_comprobante' do
    it 'validate the xml_raw with the service' do
      savon.expects(:validar_comprobante).with(@request).returns(xml_response)
      response = @service.validar_comprobante(xml_raw)
      expect(response).to be_successful
    end
  end

  describe '#validar_comprobante_request' do
    it 'create a hash with the request' do
      expect(@service.validar_comprobante_request(xml_raw)).to eq(request)
    end
  end

  describe '#request_url' do
    it 'get the request url from the application yml file' do
      expect(@service.request_url).to eq(Cesri.configuration.sandbox_reception_url)
    end

    it 'get the production request url from the configuration' do
      Cesri.configure do |config|
        config.sandbox = false
      end

      expect(@service.request_url).to eq(Cesri.configuration.recepcion_url)
    end
  end

end
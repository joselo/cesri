require 'spec_helper'

describe Cesri::AutorizacionComprobanteResponse do

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

    # AUTORIZADO
    savon.expects(:autorizacion_comprobante).with(@request).returns(xml_response)
    @savon_response = @service.autorizacion_comprobante(clave_acceso)
    @service_response = Cesri::AutorizacionComprobanteResponse.new(@savon_response)

    # NO AUTORIZADO
    savon.expects(:autorizacion_comprobante).with(@request).returns(xml_response_error)
    @savon_response_error = @service.autorizacion_comprobante(clave_acceso)
    @service_response_error = Cesri::AutorizacionComprobanteResponse.new(@savon_response_error)
  end

  after do 
    savon.unmock!
    restore_default_config
  end

  describe '#state' do
    context 'success' do
      it 'extract the state from the data savon hash' do
        expect(@service_response.state).to eq('AUTORIZADO')
      end
    end

    context 'error' do
      it 'extract the state from the data savon hash' do
        expect(@service_response_error.state).to eq('NO AUTORIZADO')
      end
    end
  end

  describe '#success?' do
    it "return true if the response was 'AUTORIZADO'" do
      expect(@service_response.success?).to eq(true)
    end

    it "return false if the response wasn't 'AUTORIZADO'" do
      expect(@service_response_error.success?).to eq(false)
    end
  end

  describe '#response' do
    it 'gets the full savon response if success' do
      expect(@service_response.response).to eq(@savon_response)
    end

    it 'gets the full savon response if error' do
      expect(@service_response_error.response).to eq(@savon_response_error)
    end
  end

  describe '#mensajes' do
    context 'success' do
      it 'is an array' do
        expect(@service_response.messages).to be_instance_of(Array)
      end

      it 'is an empty array' do
        expect(@service_response.messages.size).to eq(1)
      end
    end

    context 'errors' do
      it 'is and array ' do
        expect(@service_response_error.messages).to be_instance_of(Array)
      end

      it 'is not an empty array' do
        expect(@service_response_error.messages.size).to eq(2)
      end

      it 'is a ResponseMessage instance' do
        expect(@service_response_error.messages.first).to be_instance_of(Cesri::ResponseMessage)
      end
    end
  end

end
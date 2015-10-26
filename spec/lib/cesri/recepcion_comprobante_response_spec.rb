require 'spec_helper'

describe Cesri::RecepcionComprobanteResponse do

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

    # RECIBIDA
    savon.expects(:validar_comprobante).with(@request).returns(xml_response)
    @savon_response = @service.validar_comprobante(xml_raw)
    @service_response = Cesri::RecepcionComprobanteResponse.new(@savon_response)

    # DEVUELTA 
    savon.expects(:validar_comprobante).with(@request).returns(xml_response_error)
    @savon_response_error = @service.validar_comprobante(xml_raw)
    @service_response_error = Cesri::RecepcionComprobanteResponse.new(@savon_response_error)
  end

  after do
    restore_default_config
    savon.unmock!
  end

  describe '#state' do
    context 'success' do
      it 'gets RECIBIDA' do
        expect(@service_response.state).to eq('RECIBIDA')
      end
    end

    context 'error' do
      it 'gets DEVUELTA' do
        expect(@service_response_error.state).to eq('DEVUELTA')
      end
    end
  end

  describe '#success?' do
    it "return true if the response was 'RECIBIDA'" do
      expect(@service_response.success?).to eq(true)
    end

    it "return false if the response wasn't 'RECIBIDA'" do
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
        expect(@service_response.messages.size).to eq(0)
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
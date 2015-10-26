require 'spec_helper'

module Cesri
  describe ResponseMessage do

    let(:xml_response_reception_error) { File.read(File.join('spec', 'fixtures', 'validar_comprobante_response_error.xml')) }
    let(:xml_response_authorization_error) { File.read(File.join('spec', 'fixtures', 'autorizacion_comprobante_response_error.xml')) }

    context 'reception' do
      before do
        doc = Nokogiri::XML(xml_response_reception_error)
        doc_message = doc.xpath('//mensajes//mensaje').first
        @response_message = Cesri::ResponseMessage.new(doc_message)
      end

      describe '#initialize' do
        it 'set identificador' do
          expect(@response_message.identificador).to eq("45")
        end

        it 'set mensaje' do
          expect(@response_message.mensaje).to eq("ERROR SECUENCIAL REGISTRADO")
        end

        it 'set informacion_adicional' do
          expect(@response_message.informacion_adicional).to be_nil
        end

        it 'set tipo' do
          expect(@response_message.tipo).to eq("ERROR")
        end
      end
    end

    context 'reception' do
      before do
        doc = Nokogiri::XML(xml_response_authorization_error)
        doc_message = doc.xpath('//mensajes//mensaje').first
        @response_message = Cesri::ResponseMessage.new(doc_message)
      end

      describe '#initialize' do
        it 'set identificador' do
          expect(@response_message.identificador).to eq("39")
        end

        it 'set mensaje' do
          expect(@response_message.mensaje).to eq("FIRMA INVALIDA")
        end

        it 'set informacion_adicional' do
          expect(@response_message.informacion_adicional).to eq("La firma es invalida [Firma inválida (firma y/o certificados alterados)]")
        end

        it 'set tipo' do
          expect(@response_message.tipo).to eq("ERROR")
        end
      end
    end

  end
end
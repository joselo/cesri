require "spec_helper"

module Cesri
  describe Configuration do

    before { load_default_config }
    after { restore_default_config }

    context 'sandbox' do
      describe "#sandbox_reception_url" do
        it "default value is 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl'" do
          expect(Cesri.configuration.sandbox_reception_url).to eq 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl'
        end
      end

      describe "#sandbox_reception_url=" do
        it "can set value" do
          Cesri.configure do |config|
            config.sandbox_reception_url = 'foo'
          end

          expect(Cesri.configuration.sandbox_reception_url).to eq 'foo'
        end
      end

      describe "#sandbox_authorization_url" do
        it "default value is 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl'" do
          expect(Cesri.configuration.sandbox_authorization_url).to eq 'https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl'
        end
      end

      describe "#sandbox_authorization_url=" do
        it "can set value" do
          Cesri.configure do |config|
            config.sandbox_authorization_url = 'foo'
          end

          expect(Cesri.configuration.sandbox_authorization_url).to eq 'foo'
        end
      end
    end

    context 'production' do
      describe "#recepcion_url" do
        it "default value is 'TODO'" do
          expect(Cesri.configuration.recepcion_url).to eq 'TODO'
        end
      end

      describe "#recepcion_url=" do
        it "can set value" do
          Cesri.configure do |config|
            config.recepcion_url = 'foo'
          end

          expect(Cesri.configuration.recepcion_url).to eq 'foo'
        end
      end

      describe "#authorization_url" do
        it "default value is 'TODO'" do
          expect(Cesri.configuration.authorization_url).to eq 'TODO'
        end
      end

      describe "#authorization_url=" do
        it "can set value" do
          Cesri.configure do |config|
            config.authorization_url = 'foo'
          end

          expect(Cesri.configuration.authorization_url).to eq 'foo'
        end
      end
    end

    context 'env' do
      describe "#sandbox" do
        it "default value is true" do
          expect(Cesri.configuration.sandbox).to eq true
        end
      end

      describe "#sandbox=" do
        it "can set value" do
          Cesri.configure do |config|
            config.sandbox = false
          end

          expect(Cesri.configuration.sandbox).to eq false
        end
      end
    end

  end
end
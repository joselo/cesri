module Cesri
  class RecepcionComprobanteResponse

    attr_reader :response, :state, :messages

    def initialize(response)
      @response = response
      @state = state_value
      @messages = []

      load_messages
    end

    def success?
      @state == 'RECIBIDA'
    end

    private

    def state_value
      doc.xpath('//estado').first.content if doc.xpath('//estado').first
    end

    def load_messages
      doc.xpath('//mensajes//mensaje').each do |message|
        response_message = ResponseMessage.new(message)
        messages << response_message if response_message.identificador
      end
    end

    def doc
      @doc ||= Nokogiri::XML(@response.to_s)
    end

  end
end

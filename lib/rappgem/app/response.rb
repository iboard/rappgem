module Rappgem
  module Application
    module ApplicationProtocol

      # Base implementation of a response
      class Response
        attr_reader :errors

        # @param [Array] options
        def initialize *options
          @options = options.first
          @message = @options.fetch(:message) { "" }
          @errors  = @options.fetch(:errors)  { [] }
        end

        # @return [String]
        def message
          @message
        end

      end
    end

  end
end

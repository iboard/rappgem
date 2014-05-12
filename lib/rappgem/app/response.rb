module Rappgem
  module Application
    module ApplicationProtocol

      # Base implementation of a response
      class Response

        # @param [Array] options
        def initialize *options
          @message = options.first
        end

        # @return [String]
        def message
          @message
        end

      end
    end

  end
end

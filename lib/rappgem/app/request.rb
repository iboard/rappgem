module Rappgem
  module Application
    module ApplicationProtocol

      # Base implementation of a request. The class Request defines a command and parameters.
      # @see ApplicationProtocol
      class Request

        # @param [Symbol] command
        # @param [Array] params - additional parameters
        def initialize _context, command, *params
          @context = _context
          @command = command
          @params  = prepare_params(params)
        end

        # @return [Array]
        def params
          @params
        end

        # @return [:symbol] the name of the given command
        def command
          @command
        end

        # @return [Object] the object building this request or self if not available
        def context
          @context || self
        end

        private

        # Overwrite if you want to format params when readed
        # eg: convert to/from json
        def prepare_params _params
          _params ? _params.flatten : []
        end

      end
    end

  end
end

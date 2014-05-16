module Rappgem
  module Application
    module ApplicationProtocol

      # Base implementation of a request. The class Request defines a command and parameters.
      # @see ApplicationProtocol
      class Request

        # @param [Symbol] command
        # @param [Array] params - additional parameters
        def initialize command, *params
          @command = command
          @params  = params.flatten
        end

        # @return [Array]
        def params
          @params
        end

        # @return [:symbol] the name of the given command
        def command
          @command
        end

      end
    end

  end
end

module Rappgem
  module Application
    module ApplicationProtocol

      # Base implementation of a request
      class Request

        # @param [Symbol] command
        # @param [Array] params - additional params
        def initialize command, *params
          @command = command
          @params  = params.first
        end

        # @return [Array] of given parameters
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

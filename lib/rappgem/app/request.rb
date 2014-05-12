module Rappgem
  module Application
    module ApplicationProtocol

      class Request

        def initialize command, *params
          @command = command
          @params  = params.first
        end

        def params
          @params
        end

        def command
          @command
        end

      end
    end

  end
end

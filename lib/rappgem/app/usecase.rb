module Rappgem
  module Application
    class Usecase
      attr_reader :errors

      def initialize request
        @errors = []
        @request = request
      end

      def response
        case @request.command
        when :ping
          ApplicationProtocol::Response.new( message: @request.params.first )
        else
          @errors.push(ApplicationProtocolError.new("unknown command #{@request.inspect}"))
          ApplicationProtocol::Response.new( errors: @errors )
        end
      end

      def errors?
        !@errors.empty?
      end

    end
  end
end

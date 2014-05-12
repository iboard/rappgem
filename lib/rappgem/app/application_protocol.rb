require "ostruct"

module Rappgem
  # The application protocol
  module Application
    class ApplicationProtocolError < RuntimeError; end

    # == Implement Application behavior
    #
    # === Hard coded commands
    #
    # **ping** arg
    #
    # responds with 'arg'
    #
    # === Soft coded commands
    #
    # If your descendant from BaseApplication implements the given command
    # as a public_method, this method will be called by the application-protocol.
    #
    # @example
    #
    #    # using a hard coded command
    #    app = ApplicationFactory.app( YourApp, '-v' )
    #    req = app.build_request( self, ping: "Hello World" )
    #    resp= app.handle_request(req)
    #    resp.message #=> "Hello World"
    #
    #    # implementing your own command
    #    class MyApp < BaseApplication
    #      def say_hello request
    #        OpenStruct.new( message: "Hello, #{request.options.first}" )
    #      end
    #    end
    #
    #    req = app.build_request( self, say_hello: "the world" )
    #    resp= app.handle_request(req)
    #    resp.message #=> "Hello, the world"
    module ApplicationProtocol

      def self.included base
        base.send( :include,  InstanceMethods )
      end

      module InstanceMethods

        # @param [Object] context the calling object
        # @param [Array] options additional options
        # @return [Rappapp::Application::Request]
        def build_request context, *options
          @context = context
          OpenStruct.new( options: options.first )
        end

        # @param [Rappapp::Application::Request] request
        # @return [Rappapp::Application::Interactor]
        def handle_request request
          options = request.options
          command, *params = options.first
          msg = case command
                when :ping
                  params.first
                else
                  fail ApplicationProtocolError.new("unknown command #{command}(#{params}) in #{request}")
                end
          OpenStruct.new( message: msg )
        end

      end

    end
  end
end

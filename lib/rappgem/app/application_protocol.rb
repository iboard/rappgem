require "ostruct"
require "request"
require "response"
require "usecase"

module Rappgem

  # The module implements the application protocol, and the classes
  # Request, Response, and Usecase.
  module Application

    # Thrown in case of a protocol error
    class ApplicationProtocolError < RuntimeError; end

    # == Implement Application behavior
    #
    # === Hard coded commands (Defined in base class Usecase)
    #
    # **ping** arg
    #
    # responds with 'arg'
    #
    # === Soft coded commands (Defined by your individual descendants of Usecase)
    #
    # see examples
    #
    # @example
    #
    #    # using a hard coded command
    #    app = ApplicationFactory.app( YourApp, '-v' )
    #    req = app.build_request( self, ping: "Hello World" )
    #    resp= app.handle_request(req)
    #    resp.message #=> "Hello World"
    #
    #    # implementing your own usecases
    #    class MyUsecase < Usecase
    #      def response
    #        # do something with @request
    #        Response.new( ...build your response... )
    #      end
    #    end
    #
    #    # and handle the request with your usecase
    #    response = app.handle_request( req ) do
    #      MyUsecase.new( req )
    #    end
    #
    module ApplicationProtocol

      def self.included base
        base.send( :include,  InstanceMethods )
      end

      # Methods added to the Application instance
      module InstanceMethods

        # @param [Object] context the calling object
        # @param [Array] options additional options
        # @yield [Symbol, Array] command | params must return a Request object
        # @return [Rappapp::Application::Request]
        def build_request context, *options
          @context = context
          command, *params = *options
          block_given? ?  yield(command, params) : Request.new( context, command, params )
        end

        # @param [Request] request
        # @param [Class] usecase_class
        # @yield [Request] block must return a @Usecase object if given
        # @return [Usecase]
        def build_usecase request, usecase_class
          block_given? ?  yield(request) : usecase_class.new( request )
        end

        # Create the usecase-object and return it's response
        # @param [Rappapp::Application::Request] request
        # @yield [Request] block must return a Usecase-object if given.
        #                  Otherwise a base Usecase is instantiated.
        # @return [Rappapp::Application::Usecase]
        def handle_request request, usecase=Usecase, &block
          usecase = build_usecase( request, usecase, &block )
          usecase.response
        end

        def respond_for usecase, &block
          resp = {
            object: usecase.build_object,
            errors: usecase.errors,
            message: errors.any? ? "Error" : "Success"
          }
          if block_given?
            resp = yield(resp)
          end
          Response.new( resp )
        end


      end

    end
  end
end

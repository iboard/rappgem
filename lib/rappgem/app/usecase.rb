module Rappgem
  module Application

    # A usecase is initialized with a request object
    # and generates a response object. Errors are kept in the array @errors.
    class Usecase
      # Array of errors occured
      attr_reader :errors

      # @param [Request] request
      def initialize request
        @errors = []
        @request = request
      end

      # Instantiate the response object.
      # The base class Usecase implements "hard coded" commands (eg ping).
      # @example
      #
      #     # a.) A usecase which handles more than one command (use rarely)
      #     class MyMulticommandUsecase
      #       def response
      #         case @request.command
      #         when :your_case
      #           ..handle your case..
      #         when :other_case
      #           ..handle your other case
      #         else
      #           super
      #         end
      #       end
      #     end
      #
      #     # b.) A usecase which handles just one case and therefore can ignore command
      #     class MySpecialUsecase
      #       def response
      #         # ...handle your case here and
      #         return( Response.new( message: "X1", .... ) )
      #       end
      #     end
      #
      #     # c.) Execute usecases
      #     response1 = app.handle_request( request ) do |request|
      #       MyMulticommandUsecase.new( request )
      #     end
      #
      #     response2 = app.handle_request( request ) do |request|
      #       MySpecialUsecase.new( request )
      #     end
      #
      #     response1.message # => "Your Case"
      #     response1.message # => "X1"
      # @return [Response]
      def response
        @response ||= run
      end

      # Rerun and respond
      # @return [Response]
      def response!
        @response = nil
        response
      end



      # @return [Boolean] true if any errors occured yet
      def errors?
        !@errors.empty?
      end

      private

      def run
        message = case @request.command
                   when :ping
                     @request.params.first
                   when :date
                     @object = Time.now
                     "#{@object}"
                   else
                     @errors.push(
                       ApplicationProtocolError.new("Unknown command #{@request.inspect}")
                     )
                     "ERROR"
                   end
        @object = message
        ApplicationProtocol::Response.new( message: message, errors: @errors, object: @object )
      end
    end
  end
end

module Rappgem
  module Application
    module ApplicationProtocol

      # Base implementation of a response. A Response object has a message (String)
      # and errors (Array)
      class Response
        attr_reader :errors, :object

        # @param [Array] options
        def initialize *options
          @options = options.first
          @message = @options.fetch(:message) { "" }
          @errors  = @options.fetch(:errors)  { [] }
          @object  = @options.fetch(:object)  { nil }
        end

        # @return [String]
        def message
          @message
        end

        def errors?
          !@errors.empty?
        end

        # @return (String)
        def to_s
          self.message
        end

      end
    end

  end
end

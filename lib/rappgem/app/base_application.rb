require "singleton"
require "application_protocol"

module Rappgem

  # The Application module provides some Application-classes
  #     BaseApplication ..... Standard ruby app with no dependencies at all
  #     TerminalApplication.. Has a very simple UI through the command-line and opts
  #     SinatraApplication .. Not yet implemented
  #     RailsApplication .... Not yet implemented
  #     ....
  module Application

    # BaseApplication is the mother of all descendants of a singleton
    # Application-class.
    class BaseApplication
      include Singleton
      include ApplicationProtocol

      attr_reader :args

      def initialize *args
        args= *args if args.any?
      end

      # Use only in test-environment!
      # It resets the singleton application-object. Which should not
      # be done in real-world applications.
      def reset
        @args = nil
      end

      # Set the arguments. Can be called once only
      # @param [Array] _new_args - options to set
      # @raise RuntimeError if args initialized already
      # @return [Object]
      def args= *_new_args
        raise "Args already initialized" unless @args.nil?
        @args = _new_args.first.dup
        @args.freeze
      end

      # @param [string] name of the argument to search for
      # @return [Boolean] true if argument found.
      def has_arg? name
        args.include?(name)
      end

      # @abstract implementation
      def run *_opts
        self.to_s
      end

      # output self as string with args
      def to_s
        "#{self.class.to_s}::<#{object_id}> Args: #{args}"
      end

      def output
        raise RuntimeError, "#output is an abstract method on BaseApplication"
      end

      def next_input
        raise RuntimeError, "#next_input is an abstract method on BaseApplication"
      end
    end

  end
end


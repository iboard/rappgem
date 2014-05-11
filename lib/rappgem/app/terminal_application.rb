module Rappgem
  module Application

    # Implementation as a Terminal-application
    # Output goes to STDOUT and STDERR
    # Input is read from STDIN
    class TerminalApplication < BaseApplication

      # Outputs to_s to STDOUT
      # @see Application::BaseApplication
      def run *options
        s = super
        puts s
        s
      end
    end
  end
end

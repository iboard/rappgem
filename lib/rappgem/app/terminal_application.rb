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
        next_input do |command, parts|
          break if command == "quit"
          usecase_class = command_to_usecase(command)
          response = handle_request( Request.new( command.to_sym, parts ), usecase_class )
          output response.errors.join(", ") if response.errors?
          output response.message
        end
        output "#{s}"
      end

      # A Terminal-application prints to STDOUT
      def output object
        STDOUT.puts "#{object}"
      end

      # loop until break_at is detected and read from STDIN
      # @yield [Symbol, Array] command, parts
      def next_input break_at="quit"
        loop do
          STDOUT.printf ">"
          if line = STDIN.gets
            break if line.strip == break_at
            parts = line.split(/\s+/).map(&:strip)
            command = parts.shift
            yield(command,parts)
          end
        end
      end

      private
      def command_to_usecase _command
        begin
          usecase_class = eval( _command.to_s )
          usecase_class.ancestors.include?(Usecase) ? usecase_class : Usecase
        rescue
          Usecase
        end
      end
    end
  end
end

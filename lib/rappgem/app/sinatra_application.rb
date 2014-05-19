module Rappgem
  module Application

    class SinatraApplication < BaseApplication

      # Set the sinatra-instance for the Application.
      # Used as context for all requests
      # @param [Sinatra::App] sinatra_instance
      def sinatra=sinatra_instance
        @sinatra = sinatra_instance
      end

      # Build and execute a Usecase
      # @param [Class] usecase existing Usecase-class derived from TracesUsecase
      # @param [Array] params - optional params
      # @return [Rappgem::Response]
      def execute( usecase, *params )
        respond_json(
          handle_request(
            build_request( @sinatra, usecase.class.to_s, params ),
            usecase
          )
        )
      end

      def execute_index(params)
        find_and_execute_usecase(:index, params )
      end

      def execute_show(params)
        find_and_execute_usecase(:show, params )
      end

      def execute_put(params)
        find_and_execute_usecase(:put, params )
      end

      def execute_post(params)
        find_and_execute_usecase(:post, params )
      end

      def execute_delete(params)
        find_and_execute_usecase(:delete, params )
      end

      private
      def find_and_execute_usecase method, params
        # Setup
        resource_name = params.fetch("resource_name") {
          raise "Need a param :resource_name #{params}"
        }
        resource_id = params.fetch("resource_id") { nil }
        usecase = get_usecase_class(resource_name, method)

        # Request and Handle Usecase
        request = build_request( @sinatra, usecase, params )
        response= handle_request( request, usecase )

        # Render Response
        respond_json response
      end

      def get_usecase_class resource_name, method
        method_name = camelize(method.to_s)
        resources   = camelize(resource_name)
        usecase_name="#{resources}#{method_name}"
        eval(usecase_name)
      rescue
        raise "Usecase #{usecase_name} not found for #{resources}, #{method_name}"
      end

      def camelize _str
        return _str.upcase if _str.length < 2
        _str[0].upcase + _str[1..-1].downcase
      end

      def respond_json response
        response.errors? ? respond_with_errors(response) : respond_ok(response)
      end

      def respond_with_errors response
        @sinatra.halt 400, [ 400, response.errors ].to_json
      end

      def respond_ok response
        (response.object).to_json
      rescue => e
        @sinatra.halt(400, [ 400, "#{e.inspect}" ].to_json )
      end
    end

  end
end


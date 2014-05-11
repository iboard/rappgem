module Rappgem

  # == The Application Factory
  #
  # is responsible for instantiating a BaseApplication or a
  # descendant from BaseApplication.
  #
  # The singleton variable `@app` get's instantiated once.
  #
  # @see BaseApplication
  #
  # @example
  #
  #     app = ApplicationFactory.app( MyApplication.instance, ... )
  #
  #     # where MyApplication is a descendent from BaseApplication
  #     # ... any other arguments

  module ApplicationFactory
    extend self

    # Instantiate the app and sets immutable argumenst to it,
    # when called the first time.
    # Returns the app-object on sequential calls
    # Raises an error if singleton rule would be violated by call.
    # @param [BaseApplication] instance
    # @param [Array] args any arguments passed through to instance
    # @return [BaseApplication]
    def app instance=nil, *args
      raise "Forbidden singelton action" unless instance || @app
      return @app unless instance
      @app ||= instance.tap{|a| a.args=*args }
      @app
    end


    # Don't call this method in normal production/development-mode
    # It's supposed to reset the singleton behaviour of the
    # application-object, thus various descendants can be tested
    # through rspec. Anyhow, in standard applications the Application
    # object should not get instantiated twice.
    def reset_app
      @app.reset if @app
      @app = nil
    end
  end


end

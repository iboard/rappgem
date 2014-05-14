# Rappgem – Ruby Application Gem

The gem gives you a clean application-structure for any ruby
application. You may use it for a gem, a command-line-app, a
sinatra-app, and even for your rails-app.

## Installation

Add this line to your application's Gemfile:

    gem 'rappgem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rappgem


## Usage

### Examples

#### Simple

    class MyApp < BaseApplication
      def run *_opts
        puts "Hello World" if has_arg?("-v")
      end
    end

    app = ApplicationFactory.app( MyApp.intance, "-v" )
    app.run #=> "Hello World"

#### Complete with individual Usecase

    # implementing your own usecases
    class MyUsecase < Usecase
      def response
        # do something with @request
        Response.new(message:"...build your response...")
      end
    end

    # instantiate the application
    app = ApplicationFactory.app( BaseApplication.instance )

    # build the request
    request = app.build_request( self, :command_name, params)

    # and handle the request with your usecase
    response = app.handle_request( req ) do
      MyUsecase.new( req )
    end

    response.message # => "...build your response..."


See `spec/app/application_factory_spec.rb` and any other spec-file for
details.

## Sinatra Example

There is an example of a basic Sinatra-applicaton using Rappgem.
You can run the test-suite of this app by

    rake sinatra

To run the application

    cd examples/sinatra
    ruby app.rb

Visit "http://0.0.0.0:4567" while the app is running.
Press Ctrl+C to stop the server-app.


## TODO

This gem has not been finished yet. Next steps are:

  * Implement a command-queue for BaseApplication and TerminalApplication
  * Implement a Terminal-Example
  * Implement a RAILS-Example

### Use Terminal Application with _irb_

     $ irb -Ilib
     ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-darwin12.0]
     irb(main):001:0> require "rappgem"
     true
     irb(main):002:0> include Rappgem
     Object
     irb(main):003:0> app = ApplicationFactory.app( TerminalApplication.instance )
     #<Rappgem::Application::TerminalApplication:0x000001018a0d70 @args=[]>
     irb(main):004:0> app.run
     >ping pong
     pong
     >date
     2014-05-13 21:56:48 +0200
     >quit
     Rappgem::Application::TerminalApplication::<2160395960> Args: []
     nil

### Draft how a TerminalApplication could work

![Image 1: Terminal Application - Draft](http://dav.iboard.cc/container/rappgem/Img001-terminal-application.jpg)

### The idea behind

[Jim Weirich Talk](http://www.youtube.com/embed/tg5RFeSfBM4)

<div><iframe width="560" height="315"
    src="//www.youtube.com/embed/tg5RFeSfBM4"
    frameborder="0" allowfullscreen>
  </iframe>
</div>

## Development

### rake – TDD

run `rake` to run all tests. The output of the tests will give
you a glue what `Rappgem` is doing.


### YARD – documentation

run `yard && open doc/index.html` to generate and open the documentation
in your browser.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rappgem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

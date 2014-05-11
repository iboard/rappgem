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

### Example

    class MyApp < BaseApplication
      def run *_opts
        puts "Hello World" if has_arg?("-v")
      end
    end

    app = ApplicationFactory.app( MyApp.intance, "-v" )
    app.run #=> "Hello World"

See `spec/app/application_factory_spec.rb` and any other spec-file for
details.


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

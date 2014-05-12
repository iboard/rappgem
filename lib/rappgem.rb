require "rappgem/version"

$LOAD_PATH.unshift( File.expand_path("../rappgem/app",__FILE__) )
$LOAD_PATH.unshift( File.expand_path("../rappgem/usecases",__FILE__) )
require "application_factory"
require "base_application"
require "terminal_application"
require "standard_usecases"


# == Rappgem
#
# Rappgem is a gem, aimed to support your application-architecture.
# It can be used with any ruby-application. In a Sinatra-app, a Rails-App,
# even your NCurses-application, or anything else based on ruby.
#
# It is implemented as a singleton module named _ApplicationFactory_
# and implements classes like
#
# * _BaseApplication_, _TerminalApplication_, _SinatraApplication_, ...
# * _Usecase_
#
# The module _ApplicationProtocol_ implements classes like
#
# * _Request_, _Response_
#
# @see ApplicationFactory
# @see ApplicationProtocol
#
# @example
#     app = ApplicationFactory( MyApp.instance, *ARGS )
#
#     # Where MyApp is your descendant from BaseApplication
#     # and it should be a singleton class.
module Rappgem
end

include Rappgem
include Rappgem::Application

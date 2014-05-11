require "rappgem/version"

require "rappgem/app/application_factory"
require "rappgem/app/base_application"
require "rappgem/app/terminal_application"


# == Rappgem
#
# Rappgem is an application-architecture for your ruby application.
# It is implemented as a singleton module named _ApplicationFactory_
# and depends on class _BaseApplication_ which is responsible to take
# care of application-global stuff.
#
# @see BaseApplication
# @see ApplicationFactory
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

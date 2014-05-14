require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/support'


# load the Rappgem environment
$LOAD_PATH.unshift( File.expand_path('../../../lib',__FILE__) )
$LOAD_PATH.unshift( File.expand_path('../../../app',__FILE__) )
require 'rappgem'
include ApplicationProtocol


Encoding.default_external = 'utf-8'  if defined?(::Encoding)

class App < Sinatra::Base
  disable :show_exceptions
  enable  :raise_exceptions

  set :root, File.dirname(__FILE__)
  app = ApplicationFactory.app( TerminalApplication.instance )

  register Sinatra::AssetPack
  assets do
    css :main, ['/css/*.css']
  end

  # GET /
  get '/' do
    req = app.build_request( self, :ping, "pong" )
    @resp=app.handle_request( req )
    erb :index
  end

  # GET /date
  get '/date' do
    req = app.build_request( self, :date )
    @resp=app.handle_request( req, GetTimeUsecase )
    erb :index
  end

end

if __FILE__ == $0
  App.run!
end

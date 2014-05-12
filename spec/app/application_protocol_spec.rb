require "spec_helper"
describe Rappgem do

    describe "A concrete application" do

      class MyApp < BaseApplication

      end

      subject(:app) { ApplicationFactory.app( MyApp.instance, "-v" ) }

      it "runs a request" do
        request  = app.build_request( self, ping: "pong" )
        response = app.handle_request(request)
        expect( response.message ).to eq( "pong" )
      end

      it "fails with unknown command" do
        request  = app.build_request( self, unknown_request: "something" )
        expect {
          response = app.handle_request(request)
        }.to raise_error( ApplicationProtocolError, /unknown_request/ )
      end

    end


end

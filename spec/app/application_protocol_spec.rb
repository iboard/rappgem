require "spec_helper"
describe Rappgem do

    describe "A concrete application" do

      before :all do
        ApplicationFactory.reset_app
      end

      class MyApp < BaseApplication

      end

      subject(:app) { ApplicationFactory.app( MyApp.instance, "-v" ) }

      subject(:request) { app.build_request( self, :ping, "pong" ) }

      it "is a Request object" do
        expect( request ).to be_a ApplicationProtocol::Request
      end

      it "has a command" do
        expect( request.command ).to eq( :ping )
      end

      it "expects an Response object" do
        response = app.handle_request(request)
        expect( response ).to be_a ApplicationProtocol::Response
      end

      it "handles the request" do
        response = app.handle_request(request)
        expect( response.message ).to eq( "pong" )
      end

      it "fails with unknown command" do
        request  = app.build_request( self, :unknown_request, "something" )
        expect {
          response = app.handle_request(request)
        }.to raise_error( ApplicationProtocolError, /unknown_request/ )
      end


    end


end

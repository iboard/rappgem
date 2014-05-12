require "spec_helper"
require "ostruct"

describe Rappgem do

    describe "A concrete application" do

      before :all do
        ApplicationFactory.reset_app
      end

      class MyApp < BaseApplication

      end

      subject(:app) { ApplicationFactory.app( MyApp.instance, "-v" ) }

      describe "builds any request object" do

        subject(:request) do app.build_request( self, :ping, "pong" ) do |cmd,params|
            OpenStruct.new( command: cmd, params: params )
          end
        end

        it "can handle any request fulfilling the protocol" do
          expect( request.command ).to eq( :ping )
          expect( request.params ).to eq( ["pong"] )
        end

      end

      describe "builds a Request" do
        subject(:request) { app.build_request( self, :ping, "pong" ) }

        it "is a descendant from Request" do
          expect( request ).to be_a ApplicationProtocol::Request
        end

        it "has a command" do
          expect( request.command ).to eq( :ping )
        end

        # TODO: Move the next 3 specs to the application/interactor spec once they exists.
        it "returns a response when handled by the app" do
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


end

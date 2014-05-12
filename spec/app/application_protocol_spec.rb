require "spec_helper"
require "ostruct"

describe Rappgem do

    describe ApplicationProtocol do

      class MyApp < BaseApplication; end

      before(:all)  { ApplicationFactory.reset_app }
      subject(:app) { ApplicationFactory.app( MyApp.instance, "-v" ) }

      describe "builds any request object using a block" do

        subject(:request) do app.build_request( self, :ping, "pong" ) do |cmd,params|
            OpenStruct.new( command: cmd, params: params )
          end
        end

        it "can handle any request fulfilling the protocol" do
          expect( request.command ).to eq( :ping )
          expect( request.params ).to eq( ["pong"] )
          response = app.handle_request(request)
          expect( response.message ).to eq( "pong" )
        end
      end

      describe ApplicationProtocol::Request do

        subject(:request) { app.build_request( self, :ping, "pong" ) }

        it "is a descendant from Request" do
          expect( request ).to be_a ApplicationProtocol::Request
        end

        it "has a command" do
          expect( request.command ).to eq( :ping )
        end

        it "has params" do
          expect( request.params ).to eq( ["pong"] )
        end
      end

      describe ApplicationProtocol::Response do

        subject(:request) { app.build_request( self, :ping, "pong" ) }

        it "creates a Response object on .handle_request(request)" do
          response = app.handle_request(request)
          expect( response ).to be_a ApplicationProtocol::Response
        end

        it "implements the default 'ping'-usecase" do
          response = app.handle_request(request)
          expect( response.message ).to eq( "pong" )
        end

        it "reports an error if command not handled by usecase" do
          request  = app.build_request( self, :unknown_request, "something" )
          response = app.handle_request(request)
          expect( response.errors.first).to be_a( ApplicationProtocolError )
        end

        describe "Individual usecase" do

          class MyUsecase < Usecase
            def response
              if @request.command == :my_case
                ApplicationProtocol::Response.new( message: "MY USECASE #{@request.command} WITH #{@request.params}")
              else
                super
              end
            end
          end

          subject(:request)  { app.build_request( self, :my_case, "some", "parameter" ) }
          subject(:response) { app.handle_request(request) do MyUsecase.new( request ) end }

          it "uses MyUsecase to create response" do
            expect(response.message).to match /MY USECASE my_case WITH .*some.*parameter/
          end

          it "delegates unknown requests to baseclass" do
            request = app.build_request( self, :ping, "pong" )
            response= app.handle_request(request) do MyUsecase.new(request) end
            expect(response.message).to eq("pong")
          end
        end
      end

    end

end

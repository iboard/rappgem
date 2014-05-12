require "spec_helper"

describe "Standard Application Usecases" do

  Given(:app) { ApplicationFactory.app( BaseApplication.instance ) }

  describe "PING" do
    When(:request) { app.build_request( self, :ping, "pong" ) }
    When(:response){ app.handle_request(request) }
    Then {  expect( response.message ).to eq("pong") }
  end


  describe "GETTIME" do
    When(:request) { ApplicationProtocol::Request.new( self, :gettime ) }
    When(:response){ app.handle_request(request) do |request| GetTimeUsecase.new( request ) end }
    Then {  expect( response.object ).to be_a(Time) }
  end

end

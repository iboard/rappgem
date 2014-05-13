require "spec_helper"
include ApplicationProtocol

describe "Usecases" do

  Given(:app) { ApplicationFactory.app( BaseApplication.instance ) }

  describe "Standard (built in) usecases" do
    describe "Base class Usecase handles - PING" do
      Given(:request) { app.build_request( self, :ping, "pong" ) }
      When(:response){ app.handle_request(request) }
      Then { expect( response.message ).to eq("pong") }
    end

    describe "Usecase class GetTimeUsecase - GETTIME" do
      Given(:request) { Request.new( self, :gettime ) }
      When(:response){ app.handle_request(request,GetTimeUsecase) }
      Then { expect( response.object ).to be_a(Time) }
    end
  end

  describe "Individual Usecases (examples)" do
    describe "Post to a repository (spec/fixtures/people.rb)" do
      Given(:request) {
        Request.new( :post,
          collection: People, object: Person,
          params: { name: "Frank" }
        )
      }
      When(:response) { app.handle_request(request, PostObject) }
      Then  { expect( response.object ).to be_a(Person) }
      And   { expect( response.object.name ).to eq("Frank") }
      And   { expect( People.instance.all.count).to eq(1) }
    end
  end

end

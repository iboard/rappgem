require "spec_helper"
include ApplicationProtocol

describe Rappgem do
  describe ApplicationFactory do
    describe TerminalApplication do

      before :all do
        ApplicationFactory.reset_app
      end

      subject(:app) { ApplicationFactory.app(TerminalApplication.instance, "-v") }

      it "is a TerminalApplication" do
        expect( app ).to be_a(TerminalApplication)
      end

      it ".run() outputs to stdout" do
        STDIN.stub(:gets).and_return("quit")
        expect( STDOUT ).to receive(:puts).once
        expect( STDOUT ).to receive(:printf).exactly(1).times.with(">")
        app.run
      end

      it ".run() reads from STDIN until 'quit' and handles requests" do
        commands = ["ping pong", "date", "quit"]
        STDIN.stub(:gets).and_return { commands.shift }

        expect( STDOUT ).to receive(:puts).once.with("pong")
        expect( STDOUT ).to receive(:puts).once.with(/#{Time.now.to_s[0..10]}/)
        expect( STDOUT ).to receive(:puts).once.with(/TerminalApplication/)
        expect( STDOUT ).to receive(:printf).exactly(3).times.with(">")
        app.run
      end

      it "handles individual usecases" do
        class MyIndividualUsecase < Usecase
          def run
            Response.new( message: "My Usecase", object: @request, errors: [] )
          end
        end

        commands = ["ping pong", "MyIndividualUsecase", "quit"]
        STDIN.stub(:gets).and_return { commands.shift }

        expect( STDOUT ).to receive(:puts).once.with("pong")
        expect( STDOUT ).to receive(:puts).once.with("My Usecase")
        expect( STDOUT ).to receive(:puts).once.with(/Terminal/)
        expect( STDOUT ).to receive(:printf).exactly(3).times.with(">")
        app.run
      end

    end

  end
end


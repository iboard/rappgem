require "spec_helper"
include ApplicationProtocol

describe Rappgem do

  describe ApplicationFactory do


    describe BaseApplication do

      # In production code there can be one instance of a dedicated descendent
      # of Baseapplication only. But in test-mode all descendents has their own
      # tests and therefore multiple instances must be initialized.
      # The #reset_app method of the factory can do this.
      # Notice: Don't call #reset_app in a real applications
      before :all do
        ApplicationFactory.reset_app
      end


      subject(:app) { ApplicationFactory.app( BaseApplication.instance, "-v" ) }

      it "initializes an application instance" do
        expect( app ).to be_a(BaseApplication)
      end

      it "is a Singleton instance" do
        a = app
        b = ApplicationFactory.app
        expect(b === a).to be_true
      end

      it "args are immutable" do
        expect { app.args="-x" }.to         raise_error(RuntimeError, "Args already initialized")
        expect { app.args.push( "-x" ) }.to raise_error(RuntimeError, "can't modify frozen Array")
      end

      describe "attributes of application" do

        it ".has_attr?(str) reports true if attribute str is defined" do
          expect( app.has_arg?( '-v' ) ).to be_true
        end

        it ".has_attr?(str) reports false if attribute str is not defined" do
          expect( app.has_arg?( '-x' ) ).to be_false
        end

        it "fails when initialized twice" do
          a = ApplicationFactory.app( BaseApplication.instance, "-v" )
          b = ApplicationFactory.app( BaseApplication.instance, "-x" )
          expect( a ).to be(b)
          expect( b.args ).to include("-v")
          expect( b.args ).not_to include("-x")
        end

        it "outputs argumets with to_s" do
          expect(app.to_s).to match( /\-v/ )
        end

        it ".run() outputs to string" do
          expect(app.run).to match( /Args:.+\-v/ )
        end

      end
    end

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

    end

  end

end

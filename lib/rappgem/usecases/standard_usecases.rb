module Rappgem
  module Application

    # GET TIME USECASE
    class GetTimeUsecase < Usecase
      # @return [Response] - message, errors, object
      def response
        mytime = Time.now
        ApplicationProtocol::Response.new( message: "It's #{mytime}", errors: [], object: mytime)
      end
    end

  end
end

# Examples for usecase-specs
#
# People/Person to test a Post-Usecase
# Define something to work with
class People #################### A Collection
  include Singleton
  def initialize
    @people = []
  end
  def push item ################# With a push method
    @people.push item
  end
  def all ####################### Read entries
    @people
  end
end
class Person < OpenStruct;  end # Some object to store
module Application ############## Define the usecase
  class PostObject < Usecase
    def response
      _object = @request.params[:object].new( @request.params[:params] )
      _collection = @request.params[:collection].instance
      _collection.push _object
      ApplicationProtocol::Response.new( object: _object, message: "Object #{_object} created" )
    end
  end
end


# Examples for usecase-specs
#
# People/Person to test a Post-Usecase
# Define something to work with

# Define a Collection
class People
  include Singleton
  def initialize
    @people = []
  end
  # Usecase expects a push-method
  def push item
    @people.push item
  end
  # Test expects a all-method
  def all
    @people
  end
end

# A simple OpenStruct is enough for our spec
class Person < OpenStruct;  end

# Define the Usecase
module Application
  # Create an object of class :object and add it to :collection
  class PostObject < Usecase
    def response
      _p = @request.params.first
      _object = _p[:object].new( _p[:params] )
      _collection = _p[:collection].instance
      _collection.push _object
      ApplicationProtocol::Response.new( object: _object, message: "Object #{_object} created" )
    end
  end
end


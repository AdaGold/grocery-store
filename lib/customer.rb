class Customer
  attr_reader :ID
  attr_accessor :email, :delivery_address

def initialize(ID, email, delivery_address = {})
  # id is a number
  @ID= ID
  # email is a string
  @email = email
  # delivery_address is a hash
  @delivery_address = delivery_address
end


end

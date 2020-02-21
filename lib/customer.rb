class Customer
  attr_reader :id
  attr_accessor :email, :address

def initialize(id, email, address = {})
  # id is a number
  @id= id
  # email is a string
  @email = email
  # delivery_address is a hash
  @address = address
end


end





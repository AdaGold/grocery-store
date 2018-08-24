class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id.to_i
    @email = email.to_s
    @address = address
  end

end

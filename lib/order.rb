require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = Hash.new
    @customer = customer #replaced Customer.new(id, email, address) w/ customer and 1 test passed
    @fulfillment_status = fulfillment_status
    verify_order_status(@fulfillment_status)
  end 
  
  # create a method that lists all the fulfillment_status options
  # validate input if a status given isn't in the list
  def verify_order_status(fulfillment_status)
    # store available status options in a list 
    statuses = [:pending, :paid, :processing, :shipped, :complete]
    if !(statuses.include?(fulfillment_status))
      raise ArgumentError.new("#{fulfillment_status} is not a valid option.")
    end
  end 
  
  
end

require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
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
  
  # calculate the total cost of an order 
  # use the products hash to calculate price 
  def total
    products.values.sum 
  end 
  
  # create method to add a product to the product hash
  # 2 parameters product_name, product_price 
  # raise argument error if no product with that name is found
  def add_product(product_name, product_price)
    if products.key?(product_name)
      raise ArgumentError.new("Product already exists.")
    end
    
    products[product_name] = product_price
  end
  
  
end


order = Order.new(1, { "banana" => 1.99, "cracker" => 3.00 }, {})

puts order.products
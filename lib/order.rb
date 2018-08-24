require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :customer, :products, :fulfillment_status


  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
  end

  def total
    if @products == {} or @products == 0
      return 0
    else
      total = @products.map { |product, cost| cost }.sum
      tax = total * 0.075
      return (total + tax).round(2)
    end
  end


  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError
    else
      @products[name] = price
    end
  end

end

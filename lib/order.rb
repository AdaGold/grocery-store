class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    shipping_statuses = [:paid, :processing, :shipped, :complete, :pending]
    valid_statuses =  [:pending, :paid, :processing, :shipped,:complete]
      unless valid_statuses.include?(fulfillment_status)
        raise ArgumentError, 'Fulfillment Status is an invalid entry!'
      end
  end

  def total
    if @products.empty?
      return 0
    else
    sum = @products.values.reduce(:+)
    tax = sum * 0.075
    total = sum + tax
    return total.round(2)
    end
  end

  def add_product(product_name, price)
    if products.key?(product_name)
      raise ArgumentError, 'That product already exists - only ONE of each product allowed!'
    else products[product_name] = price
    return products
    end
  end

end

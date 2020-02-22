require 'csv'
require 'awesome_print'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
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
  
  # str = "Iceberg lettuce:88.51;Rice paper:66.35;Amaranth:1.5;Walnut:65.26"
  def self.product_hash_flatten(str)
    split_str = str.split(';')
    split_str.map! do |el|
      el.split(':')
    end
    # create hash :name => price
    product_hash = {}
    split_str.each do|product|
      product_hash[product[0]] = product[1].to_f
    end
    return product_hash
  end


# self.all - returns a collection of Order instances, representing all of the Orders described in the CSV file
 
  def self.all
    orders = []
    CSV.read('./data/orders.csv').each do |order|
      each_order = Order.new(order[0].to_i, Order.product_hash_flatten(order[1]), Customer.find(order[2].to_i), order[3].to_sym)
      orders.push(each_order)
    end
    return orders 
  end

  
  def self.find(id)
    Order.all.each do |order|
      if order.id == id
        return order 
      end 
    end
    return nil
  end

end


#   ap order
# end

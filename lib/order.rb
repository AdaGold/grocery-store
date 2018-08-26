require_relative 'customer'
require 'csv'
require 'pry'

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

  def self.all
    order_data = CSV.open("data/orders.csv")
    each_order = order_data.map do |row|
      # id[2],products[Sun dried tomatoes:90.16 ; Mastic:52.69 ; Nori:63.09 ; Cabbage:5.35],customer_id[10],status[paid]
      id = row[0].to_i
      products = {}
      product_list = row[1].split(";")
      product_list.each do |list|
        item_w_price = list.split(":")
        products[item_w_price[0]] = item_w_price[1].to_f
      end
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end
  return each_order
  end

  def self.find(order_number)
    self.all.each do |order|
      if order.id == order_number
        return order
      end
    end
    return nil
  end
  
end

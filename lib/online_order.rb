require "csv"
require_relative "order"
require_relative "customer"

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :shipping, :online_orders
    @@online_orders = []
    Customer.all

    def initialize(id, products, customer, shipping = :pending)
      @id = id
      @products = products
      @customer = Customer.find(customer)
      @shipping = shipping
    end

    def total
      if @products.empty? == true
        super
      else
        super + 10
      end
    end

    def add_product(product_name, product_price)
      if @shipping == :paid || @shipping == :pending
        super
      else
        raise ArgumentError.new("Cannot add product!")
      end
    end

    def self.all
      if @@online_orders.length == 0
        CSV.open("support/online_orders.csv", 'r').each do |line|
          id = line[0].to_i
          shipping = line.pop.to_sym
          other_info = line.drop(1)
          customer = 0
          products = []
          other_info.each do |data|
            if data.to_s == data.to_i.to_s
              customer = data.to_i
            else
              product_list = data.split(";")
              product_list.each do |item|
                separate = item.split(":")
                product_hash = {}
                product_hash[separate[0]] = separate[1].to_f
                products << product_hash
              end
            end
          end
          online_order = OnlineOrder.new(id, products, customer, shipping)
          @@online_orders << online_order
        end
        return @@online_orders
      else
        return @@online_orders
      end
    end

    def self.find(id)
      OnlineOrder.all
      if id >= 1 && id <= 100
        return @@online_orders[id-1]
      else
        return false
      end
    end

    def self.find_by_customer(customer_id)
      related_orders = []
      OnlineOrder.all.each do |order|
        if order.customer.id == customer_id
          related_orders << order
        end
      end
      return related_orders
    end

  end
end

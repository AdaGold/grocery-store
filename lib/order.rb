require "csv"

module Grocery
  class Order
    attr_reader :id, :products, :orders
    @@orders = []

    def initialize(id, products)
      @id = id
      @products = products
      if @products == nil
        @products == 0
      end
    end #--- end initialize method

    def total
      total = 0
      @products.each do |product, price|
        total = total + price
      end
      total = total + (total * 0.075).round(2)
      return total
    end #--- end total method

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end #--- end add_product method

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end #--- end remove_product method

    def self.all
      if @@orders.length == 0
        CSV.open("support/orders.csv", 'r').each do |line|
          id = line[0].to_i
          products = []
          product_list = line[1].split(";")
          product_list.each do |item|
            separate = item.split(":")
            product_hash = {}
            product_hash[separate[0]] = separate[1].to_f
            products << product_hash
          end #--- end loop to add hash of products into i.variable
          new_order = Order.new(id, products)
          @@orders << new_order
        end #--- end loop of CSV file lines
        return @@orders
      else
        return @@orders
      end
    end #--- end self.all

    def self.find(id)
      Order.all
      if id >= 1 && id <= 100
        return @@orders[id-1]
      else
        raise ArgumentError.new("Not a valid order ID!")
      end
    end #--- end self.find

  end #--- end Order Class
end #--- end Grocery module

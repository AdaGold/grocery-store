require 'csv'
require 'pry'
require 'awesome_print'

FILE_NAME = "../support/orders.csv"
module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      sum = @products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      product_names = @products.keys

      if product_names.include?(product_name) # if yogurt is already in @products hash
        return false # we did not need to add to @products, its already there
      else # yogurt is not in @ prodcuts hash
        @products[product_name] = product_price
        return true
      end #if statement
    end #add product

    def self.all
      orders = []
      CSV.read(FILE_NAME).each do |row|
        id_string = row[0]
        id = id_string.to_i

        products_string = row[1]
        products_array = products_string.split(";")

        products_hash = {}
        products_array.each do |product|
          product_pair = product.split(":")
          product_name = product_pair[0]
          product_price = product_pair[1].to_f
          products_hash[product_name] = product_price
        end
        order = Order.new(id, products_hash)
        orders << order
      end
      return orders
    end
  end
end


puts "practice"
binding.pry

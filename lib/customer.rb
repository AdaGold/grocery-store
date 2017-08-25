require "csv"

module Grocery
  class Customer
    attr_reader :id, :email, :address, :customers
    @@customers = []
    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end
    def self.all
      if @@customers.length == 0
        CSV.open("support/customers.csv", 'r').each do |line|
          id = line[0].to_i
          email = line[1]
          address = {}
          address[:street] = line[2]
          address[:city] = line[3]
          address[:state] = line[4]
          address[:zipcode] = line[5]
          new_customer = Customer.new(id, email, address)
          @@customers << new_customer
        end
        return @@customers
      else
        return @@customers
      end
    end
    def self.find(id)
      Customer.all
      if id >= 1 && id <= 35
        return @@customers[id-1]
      else
        raise ArgumentError.new("Not a valid customer ID!")
      end
    end
  end
end

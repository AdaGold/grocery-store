require 'csv'
require 'ap'

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id.to_i
    @email = email.to_s
    @address = address
  end

  # returns array of Customer objects
  def self.all
    customer_data = CSV.read("data/customers.csv")
    each_customer = customer_data.map do |line|
      id = line[0].to_i
      email = line[1]
      address = {
        street: line[2],
        city: line[3],
        state: line[4],
        zip: line[5]
      }
      Customer.new(id, email, address)
    end
    return each_customer
  end

  # returns Customer object if the id matches
  def self.find(cust_id)
    self.all.each do |customer|
      if customer.id == cust_id
        return customer
      end
    end
    return nil
  end

end

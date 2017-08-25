require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 33
      email = "heythere@friend.com"
      address = {
        street: "444 Dango Lane",
        city: "Waterbergerson",
        state: "CA",
        zipcode: "199999-0234"
      }
      person = Grocery::Customer.new(id, email, address)

      person.must_respond_to :customer
      person.customer.must_equal id
      person.customer.must_be_kind_of Integer

      person.must_respond_to :email
      person.email.must_equal email
      person.email.must_be_kind_of String

      person.must_respond_to :address
      person.address.must_equal address
      person.address.must_be_kind_of Hash
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # Check if Order.all returns an array
      all_people = Grocery::Customer.all
      all_people.must_be_kind_of Array

      # Check if each element in the array is a Customer
      all_people.each do |person|
        person.must_be_instance_of Grocery::Customer
      end

      # Check if number of Customers is same as CSV file row count
      length = Grocery::Customer.all.length
      length.must_equal 35
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customer_id = 1
      customer_email = "leonard.rogahn@hagenes.org"
      customer_address = {
        street: "71596 Eden Route",
        city: "Connellymouth",
        state: "LA",
        zipcode: "98872-9105"
      }
      Grocery::Customer.find(1).customer.must_equal customer_id
      Grocery::Customer.find(1).email.must_equal customer_email
      Grocery::Customer.find(1).address.must_equal customer_address
    end

    it "Can find the last customer from the CSV" do
      customer_id = 35
      customer_email = "rogers_koelpin@oconnell.org"
      customer_address = {
        street: "7513 Kaylee Summit",
        city: "Uptonhaven",
        state: "DE",
        zipcode: "64529-2614"
      }
      Grocery::Customer.find(35).customer.must_equal customer_id
      Grocery::Customer.find(35).email.must_equal customer_email
      Grocery::Customer.find(35).address.must_equal customer_address
    end

    it "Raises an error for a customer that doesn't exist" do
      Grocery::Customer.find(36).must_equal false
    end
  end
end

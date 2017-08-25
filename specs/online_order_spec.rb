require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.new(11, {"Bran" => 14.72}, 22, "pending")
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.new(11, {"Bran" => 14.72}, 22, :paid)
      get_customer = online_order.customer
      get_customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new(11, {"Bran" => 14.72}, 22, :paid)
      get_status = online_order.shipping
      get_status.must_be_kind_of Symbol
      get_status.wont_be_nil
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order1 = Grocery::Order.new(1337, products)
      sum1 = order1.total
      order2 = Grocery::OnlineOrder.new(1337, products, 1)
      sum2 = order2.total
      (sum1 + 10 == sum2).must_equal true
    end

    it "Doesn't add a shipping fee if there are no products" do
      order = Grocery::OnlineOrder.new(1337, {}, 1)
      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      order1 = Grocery::OnlineOrder.new(11, {"Bran" => 14.72}, 22, :processing)
      order2 = Grocery::OnlineOrder.new(12, {"Bran" => 14.73}, 23, :shipped)
      order3 = Grocery::OnlineOrder.new(13, {"Bran" => 14.74}, 24, :completed)

      proc{order1.add_product("banana", 3.22)}.must_raise ArgumentError
      proc{order2.add_product("banana", 3.22)}.must_raise ArgumentError
      proc{order3.add_product("banana", 3.22)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid statuses" do
      order1 = Grocery::OnlineOrder.new(111, {"Bran" => 14.72}, 22, :pending)
      order2 = Grocery::OnlineOrder.new(121, {"Bran" => 14.73}, 23, :paid)

      order1.add_product("banana", 3.22).must_equal true
      order2.add_product("banana", 3.22).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # OnlineOrder.all returns an array
      Grocery::OnlineOrder.all.must_be_kind_of Array

      # Everything in the array is an Order
      Grocery::OnlineOrder.all.each do |order|
        order.must_be_kind_of Grocery::Order
      end

      # The number of orders is correct
      Grocery::OnlineOrder.all.length.must_equal 100

      # The customer is present
      Grocery::OnlineOrder.all.each do |order|
        order.customer.must_be_instance_of Grocery::Customer
      end

      # The status is present
      Grocery::OnlineOrder.all.each do |order|
        order.shipping.wont_be_nil
      end
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      specific_orders = Grocery::OnlineOrder.find_by_customer(25)

      # Must be an Array
      specific_orders.must_be_kind_of Array

      # Only 1 unique number for all orders of specific customer ID
      order_numbers = []
      specific_orders.each do |order|
        order_numbers << order.customer.id
      end
      order_numbers.uniq.length.must_equal 1
    end
  end
end

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

#--------------------------------- WAVE 1 ---------------------------------- #
describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total
    end

    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})
      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Increases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end

  describe "#remove_product" do
    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is subtracted from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "Returns false if the product is not present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("apple")
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal true
    end
  end
end

#--------------------------------- WAVE 2 ---------------------------------- #
describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      # Check if Order.all returns an array
      all_items = Grocery::Order.all
      all_items.must_be_kind_of Array
      # Check if each element in the array is an Order
      all_items.each do |order|
        order.must_be_instance_of Grocery::Order
      end
    end

    it "Matches the number of orders in the CSV" do
      length = Grocery::Order.all.length
      length.must_equal 100
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      first_products = [
        {"Slivered Almonds"=>22.88},
        {"Wholewheat flour" => 1.93},
        {"Grape Seed Oil" => 74.9}
      ]
      Grocery::Order.find(1).products.must_equal first_products
      Grocery::Order.find(1).id.must_equal 1
    end

    it "Can find the last order from the CSV" do
      last_products = [
        {"Allspice" => 64.74},
        {"Bran" => 14.72},
        {"UnbleachedFlour" => 80.59}
      ]
      Grocery::Order.find(100).products.must_equal last_products
      Grocery::Order.find(100).id.must_equal 100
    end

    it "Raises an error for an order that doesn't exist" do
      Grocery::Order.find(101).must_equal false
    end
  end
end

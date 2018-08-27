# Grocery Store

Let's simulate a grocery store system! We want to be able to keep track of the orders that folks make.

This project will allow you to explore object-oriented design as well as a few other new topics. This is an individual, [stage 1](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project, and is due before class on Monday August 27th.

## Learning Goals

Skills that should be demonstrated through this project:

- Test-Driven-Development
- Using instance variables and methods
- Object composition
- Reading data from a CSV file

## Baseline Setup

1. Fork the project master.
1. Clone the forked repo: `$ git clone [YOUR FORKED REPO URL]`
1. `cd` into the dir created `$ cd grocery-store`
1. Run `git remote -v` to verify the folder you are in corresponds to the fork you have created.  
  If it is **correct** it will include your username
  If it is **incorrect** it will include "AdaGold" or "Ada-C#"
1. Run `gem install minitest-skip` to install an extra gem for testing (more on what this actually does later).

### Testing

This is the first project where you'll be writing your own tests. Following the instructions from the [TDD lecture](https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/00-programming-fundamentals/intro-to-automated-tests.md), there are three things in our project directory:

```
Rakefile
lib/
specs/
```

Each class you write should get its own file, `lib/class_name.rb`. The specs for that class will be in `specs/class_name_spec.rb`, and you can run all specs using the `rake` command from your terminal.

## Wave 1

### Learning Goals
- Create a **class**
- Write **instance methods** inside a **class** to perform actions
- Link two classes using **composition**
- Use exceptions to handle errors
- Verify code correctness by **testing**

### Testing
For Wave 1, all tests have been provided for you. For each piece of functionality that you build, you should run the tests from the command line using the `rake` command. To focus on only one test at a time, change all `it` methods to `xit` except for the **one test** you'd like to run. All tests provided should be passing at the end of your work on Wave 1.

### Requirements

#### Customer

Create a class called `Customer`. Each new Customer should include the following attributes:
- ID, a number
- Email address, a string
- Delivery address, a hash

ID should be _readable_ but not _writable_; the other two attributes can be both read and written.

#### Order

Create a class called `Order`. Each new Order should include the following attributes:
- ID, a number (read-only)
- A collection of products and their cost. This data will be given as a hash that looks like this:
    ```ruby
    { "banana" => 1.99, "cracker" => 3.00 }
    ```
    - Zero products is permitted (an empty hash)
    - You can assume that there is **only one** of each product
- An instance of `Customer`, the person who placed this order
- A `fulfillment_status`, a symbol, one of `:pending`, `:paid`, `:processing`, `:shipped`, or `:complete`
  - If no `fulfillment_status` is provided, it will default to `:pending`
  - If a status is given that is not one of the above, an `ArgumentError` should be raised

In addition, `Order` should have:
- A `total` method which will calculate the total cost of the order by:
  - Summing up the products
  - Adding a 7.5% tax
  - Rounding the result to two decimal places
- An `add_product` method which will take in two parameters, product name and price, and add the data to the product collection
  - If a product with the same name has already been added to the order, an `ArgumentError` should be raised

### Optional:
Make sure to write tests for any optionals you implement!

- Add a `remove_product` method to the `Order` class which will take in one parameter, a product name, and remove the product from the collection
  - If no product with that name was found, an `ArgumentError` should be raised

## Wave 2

### Learning Goals
- Create and use class methods
- Use a CSV file for loading data
- Create your own tests to verify method correctness

### Testing
You enter Wave 2 with all tests from Wave 1 passing. In Wave 2, all the tests for `Customer` and one of the specs for `Order` have been provided. The remaining tests are stubbed out in `order_spec.rb`. Filling in these stubs is part of Wave 2.

**When you are done with Wave 2, all your tests from Wave 1 should still pass!**

### Requirements

#### Customer

Add the following **class methods** to the `Customer` class:
- `self.all` - returns a collection of `Customer` instances, representing all of the Customer described in the CSV file
- `self.find(id)` - returns an instance of `Customer` where the value of the id field in the CSV matches the passed parameter

`Customer.find` should not parse the CSV file itself. Instead it should invoke `Customer.all` and search through the results for a customer with a matching ID.

##### Customer CSV File

Customer data lives in the file `data/customers.csv`. The data in this file has the following columns:

Field       | Type    | Description
---         | ---     | ---
Customer ID | Integer | A unique identifier corresponding to the Customer
Email       | String  | The customer's e-mail address
Address 1   | String  | The customer's street address
City        | String  | The customer's city
State       | String  | The customer's state
Zip Code    | String  | The customer's zip code

**Note:** The columns in the CSV file don't quite match the parameters for the constructor. You'll need to do some work

##### Error Handling

What should your program do if `Customer.find` is called with an ID that doesn't exist? Hint: what does [the `find` method for a Ruby array](https://ruby-doc.org/core/Enumerable.html#method-i-find) do?

#### Order

Add the following **class methods** to the `Order` class:
- `self.all` - returns a collection of `Order` instances, representing all of the Orders described in the CSV file
- `self.find(id)` - returns an instance of `Order` where the value of the id field in the CSV matches the passed parameter

As before, `Order.find` should call `Order.all` instead of loading the CSV file itself.

##### Order CSV File

Order data lives in the file `data/orders.csv`. The data in this file has the following columns:

Field       | Type    | Description
------------|---------|------------
ID          | Integer | A unique identifier for that Online Order
Products    | String  | The list of products in the following format: `name:price;nextname:nextprice`
Customer ID | Integer | A unique identifier corresponding to a Customer
Status      | String  | A string representing the order's current status

The data in this file is very different than what `Order.new` takes. You will have two big pieces of work here:

1. Parse the list of products into a hash
    - This would be a great piece of logic to put into a helper method
    - You might want to look into Ruby's `split` method
    - We recommend manually copying the first product string from the CSV file and using pry to prototype this logic
1. Turn the customer ID into an instance of `Customer`
    - Didn't you just write a method to do this?

### Optional:

- `Order.find_by_customer(customer_id)` - returns a **list** of `Order` instances where the value of the customer's ID matches the passed parameter.

## What We Are Looking For
Check out the [feedback template](feedback.md) to see what instructors will be looking for.

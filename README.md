[![Total alerts](https://img.shields.io/lgtm/alerts/g/zaidoon1/shopping-cart.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/zaidoon1/shopping-cart/alerts/)

# shopping-cart
A simple shopping cart created using Ruby on Rails.

# Summer 2019 Developer Intern Challenge

Task: Build the barebones of an online marketplace.

To do this, build a server side web api that can be used to fetch products either one at a time or all at once.
Every product should have a title, price, and inventory_count.

Querying for all products should support passing an argument to only return products with available inventory. 

Products should be able to be "purchased" which should reduce the inventory by 1. Products with no inventory cannot be purchased.

P.s. No need to make a frontend!

Extra credit (100% optional as there are lots of different ways to shine in your application): 

Fit these product purchases into the context of a simple shopping cart. 

That means purchasing a product requires first creating a cart, adding products to the cart, and then "completing" the cart.
The cart should contain a list of all included products, a total dollar amount (the total value of all products), and product inventory shouldn't reduce until after a cart has been completed.

Extra extra credit (please, only do this if you really want to, honest!):

Bonus points for making your API (at least partly) secure, writing documentation that doesn’t suck, including unit tests, and/or building your API using GraphQL.

# Design decisions

The following design decisions were made:

1. The API allows the user to fetch all products at once as specified in the challenge, however, this is extremely inefficient when dealing with large number of products and is also a security concern. If the database contains many products, then a user can crash the server by requesting all products as the server has to fetch and load all the products into memory first before sending the information back to the user. This will also increase latency between the user and the sever as large data must be sent. One way to avoid this is to add pagination where the API can be restricted to return a max number of products (for example 10 products per page) per request forcing the user to send multiple requests to obtain all the products.

2. Currently, after completing the cart checkout, the cart is emptied. This is to simulate a standard e-commerce website where after completing the purchase, you cart goes back to being empty. However, the application will obviously not store any of your previous orders like most e-commerce websites.

3. The API checks if the product is in stock when adding an item to a cart as well as when attempting to checkout just like most e-commerce websites.

4. The API currently has no access control as it was not required for the challenge. However, this is a security risk as it allows anyone to make as many requests as they want which results in high bandwidth usage and could potentially take down the server (DOS and DDOS attacks). The following can be done to mitigate this issue:
    1. Require API keys for each request made to the server. This limits the requests to only authorized individuals (for example employees and clients). The API keys can then be revoked if clients make an unreasonable number of requests within a short time frame.
    2. Setup an Intrusion Detection System (IDS) that detects when a DDOS attack is occurring and take further steps to mitigate it.
    3. Add user accounts and authentication. This is like the concept of API keys but now it's part of a full-blown e-commerce website with users.

5. The shopping cart is currently configured to use the same database for development, test, and production. This is fine for the challenge; however, it is also a security risk and should not be done in production code.

6. The API currently implements basic input validation and error handling; however, more validation should be implemented. Ideally, more research should be done to determine all the possible errors that can be raised by the Ruby/Rails functions being used. 

7. The API attempts to use SQL functions that are considered immune to SQL injection as much as possible. The API also attempts to and use as little user input as possible in the SQL queries. Before retrieving or modifying the database, the API checks if the data exists or not. This will result in extra calls which will reduce performance, however, since the data is small, I believe compromising a bit of performance is worth the added security.

# Challenges
There were two main challenges that I faced while making this application. The first was learning Ruby on Rails and the second was securing the application.

While learning Ruby on Rails, I was faced with two challenges. First understanding how Routing works, and second understanding how Active Record works. Luckily, I was able to find many tutorials about those two topics.

While attempting to make the application secure (at least partly), I had to make many decisions. The problem with security is that it always comes at a cost, usually performance or usability. My main task was to try to balance between security and performance. When designing this application, I tried to make it scalable. 

# Prerequisites
- Ruby
- Rails
- MySQL
- Git

# Installation
`$ git clone https://github.com/zaidoon1/shopping-cart.git`

`$ cd shopping-cart`

`$ bundle`

# DB configuration
1. Open the database.yml file located in shopping-cart/config
2. Change the username: and passsword: fields to your mySQL username and password

Note: The default username is testuser and the default password is password<br>
Note 2: Before attempting to load the products into the DB, please ensure the username being used has permissions to create a database, create tables and populate them

# Load products into DB
Go to root directory of the shopping cart project then run the following command:<br>
`$ rake db:drop db:create db:schema:load db:seed`

Note: If you get an "ActiveRecord::EnvironmentMismatchError" then run the following command before running the command above:<br>
`$ RAILS_ENV=development rails db:environment:set`

# Start server
Go to root directory of the shopping cart project then run the following command:<br>
`$ bin/rails s`

# Interacting with the API
There are two easy ways to interact with the API, one is to use Postman (https://www.getpostman.com/), the other is to use the API documentation below as it allows you test all the routes through a GUI

# View API documentation (using Swagger)

Visit [http://localhost:3000/api/v1/index.html](http://localhost:3000/api/v1/index.html)

# @TODO:
- Add unit tests

# Korean Skin Care (KSC) Marketplace  

## Overview
The Korean Skin Care (KSC) Marketplace is a two-way marketplace application for users to buy and sell Korean skin care products.

##  R7, R8 Problem overview
The Korean skin care regimen is well known for recommending the use of multiple products layered on top of each other. It is not uncommon for consumers of skin care products to purchase multiple items at a time. However, some of these items may end up being discarded before the product has been exhausted for various reasons:  

* Users have multiples of the same type of product and no longer wish to use them
* Allergic reactions
* Cosmetic issues where the user does not like the product's feel, fragrance or appearance on their skin
* Product is not suitable for purchaser's skin type

Currently, consumers of these products rely on generalised marketplace websites such as eBay to resell unwanted skincare products and there are no specialised websites to sell these products. 

## R9 Website URL  

https://sleepy-falls-43081.herokuapp.com/

## R10 Github Repository

https://github.com/indianbread/T2A2

## R11 - Description of marketplace app

### Purpose and target audience

To reduce wastage, improve sustainability and minimize impact to the environment, KSC was developed to allow users of Korean skin care to sell their unwanted skin care. KSC will accept products that have not reached their expiry date, have not been opened, or have not been used more than half way. KSC is not intended for commercial use.

In the case where a product has already been opened and/or used, proof of purchase date in the form of a receipt must be supplied. This is to avoid the incidence of an expired product being sold.  


**Functionality and Features**
* Administrator dashboard
  * Manage users - view, edit user details (including adding/removing admin privileges) and delete users
  * Manage product listings - admin should have access to modify and delete all listings
  * User dashboard
    * View purchase history - order number, products purchased, product summary, product listing owner, transaction date
    * Manage products - view current listings, edit listing details, delete listings
    * View previous listings
    * Manage account - view profile, edit profile, delete own account
  * Product form for adding a new product to sell and editing product details
  * Integration with Stripe payment
* Users can do both actions - buy and sell products - with a single account
* Users can pay for purchases with a credit card
* Users can fill in all user information and their address on a single form upon sign up, and update this information at any time.

If time permits, I would like to attempt to implement:
* A shopping cart function
* Searching, sorting and filtering functionality for listings

### Sitemap

![Korean Skin Care Marketplace site map](/app/assets/images/docs/KSC-sitemap.svg)


#### Screenshots 

![Desktop home page screenshot](/app/assets/images/docs/screenshot-desktop-home.png)  

![Admin dashboard screenshot](/app/assets/images/docs/screenshot-admindashboard.png)

![New product form screenshot](/app/assets/images/docs/screenshot-newproduct.png)  

![Desktop product listings page](/app/assets/images/docs/screenshot-productlistings.png)  

![Desktop product details page](/app/assets/imagesdocs/screenshot-showproduct.png)  

![Mobile product detais page](/app/assets/imagesdocs/screenshot-mobile-viewproduct.png)  



### Tech stack (e.g. html, css, deployment platform, etc)

This site is built using HTML5, CSS, and Ruby using the Ruby on Rails framework.
The product and receipt images uploaded by users for each Product object is hosted on Amazon Web Services.
The website itself is deployed on Heroku.
The application is integrated with the Stripe payment system.
The CSS and HTML styling utilises the Bootstrap framework.
The SQL database used to store the data is PostgreSQL.

## R12	User stories for your app
![User Stories](/docs/nhandang_userstories.png)


## R13	Wireframes for your app


![Home Page Wireframe](/app/assets/images/docs/wireframe-homepage.png)  

![Admin Dashboard Wireframe](/app/assets/images/docs/wireframe-admindashborad.png)  

![New product listing wireframe](/app/assets/images/docs/wireframe-addnew.png)  

![Desktop product listing page](/app/assets/images/docs/wireframe-productlistings.png)  

![Desktop product details page](/app/assets/images/docs/wireframe-viewproduct.png)  

![Mobile product details page](/app/assets/images/docs/wireframe-mobileviewproduct.png)  


## R14	Entity-Relationship Diagram
![Entity-relationship diagram](/app/assets/images/docs/rails-erd.svg)

## R15	Explain the different high-level components (abstractions) in your app  

The high level abstractions in my Ruby on Rails application are:

* **Active Record**  

  * Active Record is the model component of the Model-View-Controller (MVC) model. It acts as a layer on top of the SQL database and allows me to interact with the tables and create, read, update and delete data stored in the database using the Ruby language and Ruby objects and classes. In the controllers I can use standard Ruby library methods and class methods to retrieve and manipulate data displayed in the different pages of the websites (called views), and allow users to input data to be stored in the SQL database. Active Record enables these interactions with the database without the need for direct SQL commands. 

* **Active Storage**  

  * Active Storage allows images associated with my Product objects to be uploaded and stored onto a cloud service. For this project, the cloud service I am using to store the images is Amazon Web Services. I do not have to include an attribute in my products table in the database for the product and receipt images - it only needs to be specified in my Product model and then configured:

``` has_one_attached :picture ```  

``` has_one_attached :receipt ```

* **Creating RESTful routes**

The rails routes allow me to define RESTful routes, where the URLs for each HTTP request correspond with each controller's CRUD functionality.
For example, these are my Products routes:

``` get 'products/', to: "products#index", as: "products" ``` 
Means the root_url/products calls the HTTP GET request and will route to the Products controller's index action and display a list of all products for users to Read.

``` get 'products/new', to:'products#new', as:'new_product' ```

The URL is root_url/products, and will route to the New action of the Products controller to display a form for users to list a new product.  

``` post '/products', to:'products#create' ```  

The URL root_ur/products with route to the Create action fo the Products controller when the user submits the form. It will use the HTTP POST request to add a new listing to the database.

* **Embedded Ruby**  

The use of embedded Ruby within the HTML document allows streamlining of code. Ruby code is converted to HTML when each page is rendered in the browser. Ruby functions such as using the each method to loop through elements of an array allows HTML code for components such as cards to be created for n number of product listings without requiring the same HTML code to be written multiple times.

```` 
<% @products.each do |product|%>
<div class="card" style="width: 18rem;">
  <%= image_tag product.picture, class:"card-img-top", alt:"Card image cap" %>
  <div class="card-body diffbg">
    <h5 class="card-title"><%= product.brand.name %> <%= product.name %> <%= number_to_currency(product.price) %></h5>
    <small class="text-muted"><%= product.category.name %> <br>Listed on <%= product.created_at.localtime.to_date%></small> 
    <p class="card-text"><%= product.description%></p>
  </div>
  <div class="card-footer">
   <%= link_to 'View Details', product_path(product), class:"btn btn-outline-dark" %>
   </div>
</div>
<% end %> 
````

* **Form Helpers**

Ruby on Rail's form helpers allow the same form 'partial' to be used for both edit and new actions without requiring a HTML form to be created separately for each page. It allows me to create forms which uses a POST HTTP request upon submission to interact with the models and subsequently database records. For instance, I can update a product listing record using an edit form, which upon submission will generate a POST HTTP request, which routes to the update action of the Products controller to update a row in the products table.
The form helper also allow me to build complex forms, such as the forms I used for editing and creating a new product listing. Although this form utilises the product model, it also uses fields from the Ingredients, Brands and Categories models and updates data in these tables accordingly. The form helpers allow me to use the data from the ingredients table as a multi-select field and the data from the brands and categories tables as drop-down select fields.


## R16	Detail any third party services that your app will use

* **Stripe**  is used as the payment platform

* **Amazon Web Services** for image hosting

* **Heroku** is where the website is deployed to

It uses the gems Devise for user authentication, and CanCanCan for authorisation.
The Bootstrap gem is used for styling the website, which includes the use of CSS, HTML and Javascript.

* **Devise**  

The application uses the gem Devise to authenticate users. Unregistered users can only view the index and product listing page, and will be prompted to sign in or register to view any other content. Devise enables this functionality without requiring a sign in or registration method to be defined.
Only a before action is required to be specified, and the specific controller actions that require authentication can be selected:

```  before_action :authenticate_user!, only:[:show, :edit, :new, :update, :delete] ```

* **CanCanCan**  

CanCanCan is a gem used for authorisation. It helps keep my code DRY by allowing me to define upfront what actions and models each user has access to in the ability.rb model file, then call on this model using simple lines of code in the controllers and view pages to check for authorisation.

The ability.rb model contains the following:

````
    can :read, Product, public: true
    can :read, Category, public: true
    can :read, Brand, public: true
    can :read, Ingredient, public: true

    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can :read, Product
      can :read, Category
      can :read, Brand
      can :read, Ingredient
      can :read, :create, Order, user_id: user.id
      can :crud, Product, user_id: user.id
      can :crud, ProductIngredient
      can :crud, UserInfo, user_id: user.id
      can :crud, Address, user_id: user.id
      if user.admin?
        can :manage, :all 

````
This means that users who are not signed in only has read permissions for Products, Category, Brand snd Ingredient objects.
Users who are registered have the same read only permissions as unregistered users, but they have additional permission to create, update and delete Product, Order, UserInfo and Address object which are associated with their user ID.
Administrator users have permission to create, read, update and delete all objects, even those that are not their own.  


If a user with restricted abilities (i.e. unregistered and non-admin users) attempts to access unauthorised content they will be redirected to a page that informs them that they are not authorised.  

* **Bootstrap**  

To make styling process more efficient and to improve the responsiveness of my website I used the Bootstrap gem for CSS styling.

* **Ransack**  

I used the Ransack gem to create a simple search and filter form for my product listings page.

## R17	Describe your projects models in terms of the relationships (active record associations) they have with each other

* product and category: 
  * one category has many products
  * one product belongs to one category

* brand and product:
  * one brand contains many products
  * one product belongs to one brand

* ingredients, products and product_ingredients:
  * one product has many ingredients, through product_ingredients
  * one ingredient is in many products, through product_ingredients
  * If a product or ingredient is destroyed, the product_ingredient objects associated with the product or ingredient will also be destroyed.


* user and user_info:
  * one user has one user_info
  * one user_info belongs to one user
  * If a user object is destroyed, the user_info associated with that user_id will also be destroyed.
  * An enum is used to associate an integer with 'male' and 'female' strings and enable these strings to be stored as integer values in the database.

* user and addresses:
  * one user has many addresses
  * one address belongs to one user
  * If a user object is destroyed, the addresses associated with that user_id will also be destroyed.

* user and orders:
  * one user has many orders
  * one order belongs to one user

* products and order_lines:
  * one order line has one product
  * one product belongs to one order_line

* orders and order_lines:
  * one order can have many order_lines
  * one order_line belongs to one order

* user and products:
  * one user has many products
  * one product belongs to one user
  
Images:  The images are included in my Product model but not in the products table itself.

* One product has one picture attached  
* One product has one receipt attached.

* ability:
  * This is the model that is generated by the gem CanCanCan. Although it has no explicit relationship with other tables (e.g. no belongs to or has one relationship), it determines the permissions that the three types of users - an unregistered user, a registered user, and an administrator- has by authorising user accounts and determining which pages and actions each user has access to.

  #### Validations

  The validations are mostly located in my Product model to ensure that the data entered in the Product listing form by users adheres to a consistent format and that the minimum amount of information required is entered. A lot of cosmetic products don't have an explicit expiry date. Rather, the expiry is usually x amount of months from the date opened, therefore, I only made the expiry field and receipt for proof of purchase date mandatory for used products.

  ````
  validates :brand, length: { in: 1..60, message: "must be between 1 and 60 characters"  }
  validates :name, length: { in: 3..60, message: "must be between 3 and 60 characters"  }
  validates :description, length: { in: 20..255, message: "must be between 20 and 255 characters" }
  validates :price, numericality: { greater_than_or_equal_to: 5, message: "must be at least $5"  }
  validates :name, :description, :category, :brand, :used, :price, :picture, presence: true 
  validates :expiry_date, :receipt, presence: true, if: Proc.new { |product| product.used == 'yes'}
  ````

  #### Nested attributes

  To enable attributes from other models to be used in the same product listing form, I needed to declare them in the Product model. The same applies for the User model.

  Product model:

  ````
  accepts_nested_attributes_for :ingredients, :brand, :category
  ````

  User model:

  ````
  accepts_nested_attributes_for :user_info, :addresses, :orders
  ````

## R18	Discuss the database relations to be implemented in your application  

My database will have 10 tables, consisting of:
 * 4 parent tables:  

    * categories - to categorise the products (e.g. cleanser, moisturiser). This should be only one to two words, therefore I have chosen the data type of string. As the categories will be reused extensively by each product since there are only a handful of categories which all the products fall under I have put categories in their own table for efficiency.

    * brands - each product has a brand. The brand name is usually concise, therefore I have chosen the variable character/string data type. I put brands in their own table with only one attribute aside from the primary key as one brand typically has many products, and will be reused extensively.

    * ingredients - I chose to put the ingredients in their own table rather than incorporate them into the product table as I intend for only common and/or popular active ingredients to be included in the product listings, and the same active ingredients are used in many products. I have chosen the data type of variable character/string.

    * users - this table will be generated by the gem Devise. I have added the admin attribute to this table, with a default value of false as most accounts will not be an administrator account. The admin attribute will allow me to manage account authorisations as the administrator accounts has access to more content compared to a regular user account.

 * 4 child tables: 

    * products - this table will store the details of each product listing, and contain the brand_id as the foreign key. It will contain 1-2 images - 1 product image and 1 image of the purchase receipt for used products. I did not include the image columns in the product table as the images will use Rail's Active Storage functionality and therefore will not be stored in the database itself.  

   * orders - this table will record the order details and the total amount of the order. Although the total amount will be calculated based on the price of the items I am choosing to store it in its own field to hopefully retrieve this information easily on the shopping cart page that I will be implementing. This table has the user_id as the foreign key. The total amount is stored as a decimal to accommodate for decimal prices e.g. $19.95.

    * user_infos: It was recommended that the users table generated by Devise not be modified as there has been difficulty retrieving information from user-generated fields via the controller. Therefore, I will be implementing a separate table to store user information such as name and gender to avoid potential issues. This table will have a one-to-one relationship with the Devise generated user table. I have chosen to use the data type of integer for gender as I will use enums to display the values of 'female' and 'male'.   

    *  addresses: I will be storing each user's address in a separate table as one user may have more than one address (billing and postal), and a user may not have any addresses recorded until they wish to purchase or sell an item. I want the house/unit number, street name and type to be stored in 1 field called street_number with a variable character data type as it will include both numbers and letters. I have chosen the data type of integer for postcode.

 * 2 join tables:

    * product_ingredients: one product will have multiple ingredients, and the same ingredients are in many products. The join table between these two tables will be the product_ingredients table which stores the product_id and ingredient_id for each product-ingredient combination as foreign keys.

   * order_lines: It is not ideal for the user to have to make one purchase at a time, thus I aim to make a shopping cart function if time permits. To allow for multiple orders of multiple products to be processed in one transaction, I have included an order line table which stores the product_id and order_id as foreign keys.


## R19	Provide your database schema design

````
ActiveRecord::Schema.define(version: 2019_10_29_010249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "street_number"
    t.string "suburb"
    t.integer "postcode"
    t.string "state"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_lines", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_lines_on_order_id"
    t.index ["product_id"], name: "index_order_lines_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_ingredients", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_product_ingredients_on_ingredient_id"
    t.index ["product_id"], name: "index_product_ingredients_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.bigint "brand_id", null: false
    t.string "name"
    t.date "expiry_date"
    t.integer "used"
    t.decimal "price"
    t.text "description"
    t.boolean "sold", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "surname"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "order_lines", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "product_ingredients", "ingredients"
  add_foreign_key "product_ingredients", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "users"
  add_foreign_key "user_infos", "users"
end
````

## R20	Describe the way tasks are allocated and tracked in your project

I am using Trello to break down the project into small tasks and to keep track of the progress of each task and any bugs or issues which arises. I have assigned a due date for each high priority task to ensure that I am able to complete the project within the allocated time frame. I have included the smaller tasks in the Trello board but have not assigned a due date as the tasks will be completed incrementally as I code the application.  


![Trello Screenshot](/app/assets/images/docs/trello-251019.png)  

![Trello Screenshot](/app/assets/images/docs/trello-291019.png)  

![Trello Screenshot](/app/assets/images/docs/trello-011119.png)

![Trello Screenshot](/app/assets/images/docs/trello-031119.png)

![Trello Screenshot](/app/assets/images/docs/trello-071119.png)

![Trello Screenshot](/app/assets/images/docs/trello-091119.png)


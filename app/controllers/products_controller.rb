class ProductsController < ApplicationController
  #authentication and authorisation for product listings index page not required
  before_action :authenticate_user!, only:[:show, :edit, :new, :update, :delete]
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  skip_authorize_resource :only => [:index]
  
  def index
    # from Ransack gem - assigning the instance variable for the results when the search function is used to parse the search parameters.
    # Only want to display products which have not been sold.
    @q = Product.where(sold: false).ransack(params[:q])
    # to enable search by category and brand
    @products = @q.result.includes(:category, :brand)
  end

  def admin_products
    # product listing will display all products listed in reverse chronological order of date created
    @products = Product.all.sort_by { |k,v| k["created_at"]}.reverse
    # do not allow non-admin users to view this page
    if current_user.admin? == false
      redirect_to not_authorised_path
    end
  end

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: [ 'card' ],
      customer_email: current_user.email,
      line_items: [{
        name: @product.name,
        description: @product.description,
        amount: @product.price.to_i * 100,
        currency: 'aud',
        quantity: 1
      }],
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          product_id: @product.id
        }
      },
      success_url: "#{root_url}payments/success?userId=#{current_user.id}&productId=#{@product.id}",
      cancel_url: "#{root_url}products"
    )

    @session_id = session.id
  end

  def edit
    # do not allow sold products to be modified
    if @product.sold == true
      redirect_to product_path, alert: 'Sold items cannot be modified'
    end
  end

  def update
    if @product.update(product_params)
      # parse all ingredient IDs from multi-select to an array
      ingredient_ids = params[:product][:ingredient_id]
      if ingredient_ids != nil
        # if new ingredient IDs are selected, clear the previous selection
        @product.ingredients.clear
        # iterate through each ingredient ID and create a new ProductIngredient object and row in the product_ingredients table for the product ID and ingredient ID
        ingredient_ids.each do |ingredient|
        ProductIngredient.create(product_id:@product.id, ingredient_id: ingredient)
      end
    end
      redirect_to @product
    else
      render :edit
    end
  end

  def new
    @product = Product.new 
  end

  def create
    #create a new product object and assign the current user's ID as the user ID associated with the product
    @product = current_user.products.new(product_params)
    if @product.save
      ingredient_ids = params[:product][:ingredient_id]
      ingredient_ids.each do |ingredient|
        ProductIngredient.create(product_id:@product.id, ingredient_id: ingredient)
      end
      redirect_to @product
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product listing was successfully deleted'
  end

  private

  def product_params
    #product params sanitized to accommodate additional attributes from category, brand, order and order line models for nested forms and future shopping cart functionality
    params.require(:product).permit( :user_id, :category_id, :brand_id, :name, :expiry_date, :used, :price, :description, :sold, :picture, :receipt, {:ingredient_ids => []}, ingredients_attributes: [:name], category_attributes: [:name], brand_attributes: [:name], orders_attributes: [:order_id, :total_amount], order_line_attributes: [:product_id, :order_id])
  end

end

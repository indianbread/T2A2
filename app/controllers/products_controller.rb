class ProductsController < ApplicationController
  before_action :authenticate_user!, only:[ :edit, :new, :update, :delete]
  before_action :set_product, only:[ :show, :edit, :update, :destroy]
  # before_action :set_user_products, only: [ :edit, :update, :delete ]
  

  def index
    @products = Product.where(sold: false)
    end
    
  end

  # def show

  # end

  def show
    @order = Order.create(user_id: current_user.id, total_amount: @product.price)
    @order_line = OrderLine.create(order_id: @order.id, product_id: @product.id)
    session = Stripe::Checkout::Session.create(
    payment_method_types: [ 'card' ],
    customer_email: current_user.email,
    line_items: [{
    name: @product.name,
    description: @product.description,
    amount: @product.price.to_i * 100,
    #stripe money is in cents, therefore need to multiple by 100
    currency: 'aud',
    quantity: 1
    }],
    payment_intent_data: {
    metadata: {
    user_id: current_user.id,
    order_id: @order.id
    }
    },
    success_url: "#{root_url}payments/success?userId=#{current_user.id}&orderId=#{@order.id}",
    cancel_url: "#{root_url}listings"
    )

    @session_id = session.id

  end

  def edit
    authorize! :update, @product
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end

  end

  def new
    @product = Product.new
    
  end

  def create
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
    authorize! :destroy, @product
    @product.destroy
    redirect_to products_path, notice: 'Product listing was successfully deleted'


  end

  private

  def product_params
    params.require(:product).permit( :user_id, :category_id, :brand_id, :name, :expiry_date, :used, :price, :description, :sold, :picture, :receipt, {:ingredient_ids => []}, ingredients_attributes: [:name], category_attributes: [:name], brand_attributes: [:name], orders_attributes: [:order_id, :total_amount], order_line_attributes: [:product_id, :order_id])
  end


  def set_product
    id = params[:id]
    @product = Product.find(id)
    @brand = @product.brand
    @category = @product.category
    @ingredients = @product.ingredients
  end


  def set_user_products
    @product = current_user.products.find_by_id(params[:id])
  end


end

class ProductsController < ApplicationController
  before_action :authenticate_user!, only:[ :edit, :new, :update, :delete]
  before_action :set_product, only:[ :show, :edit, :update, :destroy]
  # before_action :set_user_products, only: [ :edit, :update, :delete ]
  

  def index
    @products = Product.where(nil)
    filtering_params(params).each do |key,value|
      @products = @products.public_send(key, value) if value.present?
    end
    
  end

  def show


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
    params.require(:product).permit( :user_id, :category_id, :brand_id, :name, :expiry_date, :used, :price, :description, :sold, :picture, :receipt, {:ingredient_ids => []}, ingredients_attributes: [:name], category_attributes: [:name], brand_attributes: [:name])
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

  def filtering_params(params)
    params.slice(:category_id, :starts_with, :brand_id)
  end

end

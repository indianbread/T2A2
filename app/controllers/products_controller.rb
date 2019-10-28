class ProductsController < ApplicationController
  before_action :authenticate_user!, only:[ :edit, :new, :update, :delete]
  before_action :set_product, only:[ :show]

  def index
    @products = Product.where(nil)
    filtering_params(params).each do |key,value|
      @products = @products.public_send(key, value) if value.present?
    end
  end

  def show

  end

  def edit
  end

  def new
    @product = Product.new
    @product.user_id = current_user
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect to @product
    else
      render :new
  end
end

  def delete
  end

  private

  def product_params
    params.require(:product).permit( :user_id, :category_id, :brand_id, :name, :expiry_date, :used, :price, :description, :sold, :picture, :receipt )
  end

  def set_product
    id = params[:id]
    @product = Product.find(id)
  end

  def filtering_params(params)
    params.slice(:category_id, :starts_with, :brand_id)
  end

end

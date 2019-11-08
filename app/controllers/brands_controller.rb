class BrandsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  skip_authorize_resource :only => [:index]

  def index
    @brands = Brand.all
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      redirect_to brands_path, notice: 'Brand successfully updated'
    else
      render :edit
    end
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to brands_path, notice: 'Brand successfully added'
    else
      render :new
    end
  end

  def destroy
    @brand.destroy
    redirect_to brands_path, notice: 'Brand was successfully deleted'
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

end

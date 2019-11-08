class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  skip_authorize_resource :only => [:index] #any user can read the categories

  def index
    @categories = Category.all
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category successfully updated'
    else
      render :edit
    end
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category successfully added'
    else
      render :new
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'Category was successfully deleted'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end

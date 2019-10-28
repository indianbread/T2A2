class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorise_user
  before_action :set_cat, only: [:show, :edit, :update, :delete]
  def index
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
  end

  def delete
  end

  private

  def set_cat
    @category = Category.find(params[:id])
  end

  def authorise_user
    if current_user.user_info.admin == false
      redirect to root_path 


end

class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]

  def index
    @users = User.where.not(:id => current_user.id)
  end

  def new
    @user = User.new
    @user.user_info = UserInfo.new
    @address = @user.addresses.new
  end

  def show

  end

  def create
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    params[:user].delete(:current_password) if params[:user][:password].blank? and params[:user][:password_confirmation].blank? and params[:user][:password_confirmation].blank?
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to @user
    else
      render :new
    end
  end

  def edit

  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    params[:user].delete(:current_password) if params[:user][:password].blank? and params[:user][:password_confirmation].blank? and params[:user][:current_password].blank?
    if @user.update(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to users_path
    else
      flash[:notice] = 'Error: user unable to be deleted'
      redirect_to users_path
    end
  end 

  private

  def user_params
     params.require(:user).permit(:email, :password, :password_confirmation,:current_password, :admin, user_info_attributes: [:first_name, :surname, :gender], addresses_attributes: [:street_number,:suburb, :postcode, :state, :country])
  end

end

class UserInfosController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user_info, only: [:index, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user_info.update(user_info_params)
      redirect_to @user_info
    else
      render :edit
    end
  end

  def new
    @user_info = UserInfo.new
  end

  def create
    @user_info = current_user.user_infos.new(user_info_params)
    # @user_detail.user_id = current_user.id

    if @user_info.save
      redirect_to @user_info
    else
      render :new
    end

  end

  def destroy
    @user_info.destroy
    redirect_to root_path, notice: 'User Information successfully deleted'
  end
  
  private

  # def set_user_info
  #   @user_info = current_user.user_info
  # end
  def user_info_params
    params.require(:user_info).permit(:user_id, :first_name, :surname, :gender )
  end
end

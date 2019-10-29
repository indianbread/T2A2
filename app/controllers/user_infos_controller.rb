class UserInfosController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_info = current_user.user_info

  end

  def show
  end

  def edit
  end

  def destroy
  end
end

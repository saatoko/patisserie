class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def index
    @users = User.all
  end

  def new
    @product = Product.new
  end

  def create
    User.create(user_params)
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
  end

  def siteguide
  end

  private

  def product_params
    params.require(:user).permit(:nickname, :email, :gender_id, :profession_id, :password, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

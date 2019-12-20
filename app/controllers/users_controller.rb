class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @product = Product.new
  end

  def siteguide
  end
end

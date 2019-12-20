class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def siteguide
  end
end

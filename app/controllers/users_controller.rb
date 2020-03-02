class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    User.create(user_params)
  end

  def show
    @user = User.find_by(id: params[:id])
    @votes = Vote.where(user_id: @user.id)
  end

  def edit
  end

  def update
    @user.update(user_params)
  end

  def siteguide
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :gender_id, 
      :profession_id, 
      :password, 
      :profile,
      votes_attributes: [:id, :user_id, :recipes_id])
  end

  def set_user
    @user = User.find(params[:id])
  end
end

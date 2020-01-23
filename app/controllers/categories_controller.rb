class CategoriesController < ApplicationController
  before_action :set_category, except: [:index, :new, :create, :show, :edit, :update]
  # def parent_category
  #   @category = Category.all
  # end
  
  private
  def category_params
    params.require(:category).permit(:name, :ancestry)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end

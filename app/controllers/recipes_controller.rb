class RecipesController < ApplicationController
  before_action :recipe_post, except: :index
  before_action :set_recipe, only: [:show]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_images.build
    @recipe.recipe_videos.build
  end

  def create
    Recipe.create(recipe_params)
    redirect_to recipes_path
  end

  def show
  end

  private
  
  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :genre_id, :difficulty_id, :servers, :cookingtime, :restingtime, :bakingtime, :bakingtemperature, :instruments, :cookingpoint, recipe_methods_attributes: [:method], recipe_ingredients_attributes: [:ingredients], recipe_images_attributes: [:image], recipe_videos_attributes: [:video]).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_post
    redirect_to action: :index unless user_signed_in?
  end
end

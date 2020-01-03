class RecipesController < ApplicationController
  before_action :recipe_post, except: :index
  before_action :set_recipe, except: [:index, :new, :create, :show, :edit, :update]
  
  def index
    @recipes = Recipe.includes(:recipe_images, :recipe_ingredients, :recipe_videos).order('created_at DESC')
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_images.build
    @recipe.recipe_videos.build
    @recipe.recipe_ingredients.build
    # @recipe_image = @recipe.recipe_images.build
    # @recipe_video = @recipe.recipe_videos.build
    # @recipe_ingredient = @recipe.recipe_ingredients.build
  end

  def create
    Recipe.create(recipe_params)
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private
  
  def recipe_params
    params.require(:recipe).permit(
      :name, 
      :genre_id, 
      :difficulty_id, 
      :servers, 
      :cookingtime, 
      :restingtime, 
      :bakingtime, 
      :bakingtemperature, 
      :instruments, 
      :cookingpoint, 
      :method, 
      recipe_ingredients_attributes: [:id, :ingredients, :quantity, :_destroy], 
      recipe_images_attributes: [:image, :_destroy], 
      recipe_videos_attributes: [:video, :_destroy])
      .merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_post
    redirect_to action: :index unless user_signed_in?
  end

end


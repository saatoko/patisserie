class VotesController < ApplicationController
  before_action :set_recipe, only: [:create, :destroy]
  def create
    @vote = Vote.create(user_id: current_user.id, recipe_id: params[:recipe_id])
    @votes = Vote.where(recipe_id: params[:recipe_id])
    @recipe.reload
    
  end

  def destroy
    vote = Vote.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    vote.destroy
    @votes = Vote.where(recipe_id: params[:recipe_id])
    @recipe.reload

  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

end


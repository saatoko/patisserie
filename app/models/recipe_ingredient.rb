class RecipeIngredient < ApplicationRecord
  # belongs_to :recipe, inverse_of: :recipe_ingredients
  belongs_to :recipe
  validates :ingredients, presence: true
  validates :quantity,    presence: true
end

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, optional: true
  validates :ingredients, presence: true
  validates :quantity,    presence: true
end

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, optional: true
  # validates :recipe,      presence: true
  validates :ingredients, presence: true
  validates :quantity,    presence: true
end

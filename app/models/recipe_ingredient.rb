class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  validates :ingredients, presence: true
  validates :quantity,    presence: true
end

class RecipeImage < ApplicationRecord
  belongs_to :recipe, optional: true
  mount_uploader :image, ImageUploader
  # validates :recipe, presence: true
  validates :image, presence: true
end

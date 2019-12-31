class RecipeImage < ApplicationRecord
  belongs_to :recipe
  mount_uploaders :image, ImageUploader
end

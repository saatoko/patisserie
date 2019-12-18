class RecipeVideo < ApplicationRecord
  belongs_to :recipe
  mount_uploader :video, VideoUploader
end

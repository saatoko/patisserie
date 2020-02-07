class RecipeVideo < ApplicationRecord
  belongs_to :recipe, optional: true
  mount_uploader :video, VideoUploader

  validates :video, presence: true
end

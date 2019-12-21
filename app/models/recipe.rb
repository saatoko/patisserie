class Recipe < ApplicationRecord
  belongs_to :user
  has_many   :comments
  has_many   :recipe_images, dependent: :destroy
  has_many   :recipe_videos,  dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :difficulty
end

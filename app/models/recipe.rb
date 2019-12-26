class Recipe < ApplicationRecord
  belongs_to :user
  has_many   :comments
  has_many   :recipe_images,      dependent: :destroy
  has_many   :recipe_videos,      dependent: :destroy
  has_many   :recipe_methods,     dependent: :destroy
  has_many   :recipe_ingredients, dependent: :destroy

  validates :name,              presence: true
  validates :genre_id,          presence: true
  validates :difficulty_id,     presence: true
  validates :servers,           presence: true
  validates :cookingtime,       presence: true
  validates :restingtime,       presence: true
  validates :bakingtime,        presence: true
  validates :bakingtemperature, presence: true
  validates :instruments,       presence: true
  validates :cookingpoint,      presence: true
  accepts_nested_attributes_for :recipe_images
  accepts_nested_attributes_for :recipe_videos
  accepts_nested_attributes_for :recipe_methods
  accepts_nested_attributes_for :recipe_ingredients

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :difficulty
end

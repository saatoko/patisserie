class Recipe < ApplicationRecord
  belongs_to :user
  has_many   :comments
  has_many   :recipe_images,      dependent: :destroy
  accepts_nested_attributes_for :recipe_images,       allow_destroy: true
  has_many   :recipe_videos,      dependent: :destroy
  accepts_nested_attributes_for :recipe_videos,       allow_destroy: true
  has_many   :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
  accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true

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
  validates :method,            presence: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to_active_hash :difficulty
end

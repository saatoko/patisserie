class Recipe < ApplicationRecord
  belongs_to :user
  has_many   :comments
  has_many   :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  has_many   :recipe_images,      dependent: :destroy
  accepts_nested_attributes_for :recipe_images,      allow_destroy: true
  has_one    :recipe_video,       dependent: :destroy, class_name: RecipeVideo
  accepts_nested_attributes_for :recipe_video,       allow_destroy: true
  belongs_to :category
  accepts_nested_attributes_for :category,           allow_destroy: true
  
  validates :user,              presence: true
  validates :category,          presence: true
  validates :name,              presence: true
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
  # belongs_to_active_hash :genre
  belongs_to_active_hash :difficulty
end

# cocoon
# has_many   :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
# accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true

# validates :genre_id,          presence: true
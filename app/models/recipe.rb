class Recipe < ApplicationRecord
  belongs_to :user
  has_many   :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  has_many   :recipe_images,      dependent: :destroy
  accepts_nested_attributes_for :recipe_images,      allow_destroy: true
  has_one    :recipe_video,       dependent: :destroy
  accepts_nested_attributes_for :recipe_video,       allow_destroy: true
  belongs_to :category, optional: true

  has_many :votes, dependent: :destroy
  # レシピをいいねする
  def vote_user(user_id)
    votes.find_by(user_id: user_id)
  end

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
  validates :votes_count,       presence: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :difficulty
end

# cocoon
# has_many   :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
# accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true

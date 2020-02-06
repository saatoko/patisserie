class Vote < ApplicationRecord
  belongs_to :recipe, counter_cache: :votes_count
  belongs_to :user
  validates :user_id, presence: true
  validates :recipe_id, presence: true
end

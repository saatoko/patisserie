class Category < ApplicationRecord
  has_many :recipes
  has_ancestry
  validates :name,  presence: true
end

class Category < ApplicationRecord
  has_many :recipes
  accepts_nested_attributes_for :recipes, allow_destroy: true
  belongs_to :parent, class_name: :Category
  has_many :children, class_name: :Category, foreign_key: :ancestry
  has_ancestry
  validates :name,  presence: true
  validates :ancestry,  presence: true
end

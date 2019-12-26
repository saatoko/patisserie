class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes
  has_many :comments

  validates :nickname,      presence: true, uniqueness: true, length: { in: 2..20 }
  validates :email,         presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :gender_id,     presence: true
  validates :profession_id, presence: true
  validates :password,      presence: true, length: { minimum: 8 }
  validates :profile,       presence: true, length: { maximum: 100 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :profession
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  validates_format_of :nickname, with: /^[ｧ-ﾝﾞﾟぁ-んァ-ンa-zA-Z0-9_\.]*$/, multiline: true
  validates :nickname,      presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,         presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :gender_id,     presence: true
  validates :profession_id, presence: true
  validates :password,      presence: true, length: { minimum: 8 }
  validates :profile,       presence: true, length: { maximum: 100 }

  # attr_writer :login

  # def login
  #   @login || self.nickname || self.email
  # end

  # attr_accessor :login

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(nickname) = :value OR lower(email) = :value", { value: [:login.downcase] }]).first
  #   elsif conditions.has_key?(:nickname) || conditions.has_key?(:email)
  #     conditions[:email].downcase! if conditions[:email]
  #     where(conditions).first
  #   end
  # end

  validate :validate_nickname

  def validate_nickname
    if User.where(email: nickname).exists?
      errors.add(:nickname, :invalid)
    end
  end

  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["nickname = :value OR lower(email) = lower(:value)", { value: login }]).first
    else
      where(conditions).first
    end
  end

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["nickname = :value OR lower(email) = lower(:value)", { value: [:login.downcase] }]).first
  #   else
  #     conditions[:email].downcase! if conditions[:email]
  #     where(conditions).first
  #   end
  # end

  has_many :recipes
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :profession
end

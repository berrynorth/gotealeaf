class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 8}, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates_confirmation_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create

  sluggable_column :username

  def admin?
    self.role == "admin"
  end
end
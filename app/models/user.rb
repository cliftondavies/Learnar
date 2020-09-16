class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL}
  validates :password, presence: true, length: { in: 6..16 }
  validates :username, presence: true, length: { in: 4..15 }, uniqueness: { case_sensitive: false }
  validates :full_name, presence: true

  has_many :incomings, class_name: 'Following', foreign_key: :followed_id, inverse_of: :followed,
                       dependent: :destroy
  has_many :outgoings, class_name: 'Following', foreign_key: :follower_id, inverse_of: :follower,
                       dependent: :destroy

  has_many :followers, through: :incomings
  has_many :followeds, through: :outgoings

  has_many :progress_updates, foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :likes, inverse_of: :user, dependent: :destroy

  scope :most_recent, -> { order(created_at: :desc) }
  scope :random, -> { take(3) }

  def users_to_follow
    User.where.not(id: (followeds + [self])).most_recent
  end
end

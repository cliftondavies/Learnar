class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :format_input

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :password, presence: true, length: { in: 6..16 }
  validates :username, presence: true, length: { in: 4..15 }, uniqueness: true
  validates :full_name, presence: true

  has_many :incomings, class_name: 'Following', foreign_key: :followed_id, inverse_of: :followed,
                       dependent: :destroy
  has_many :outgoings, class_name: 'Following', foreign_key: :follower_id, inverse_of: :follower,
                       dependent: :destroy

  has_many :followers, through: :incomings
  has_many :followeds, through: :outgoings

  has_many :progress_updates, foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :likes, inverse_of: :user, dependent: :destroy

  scope :random, -> { take(3) }

  def users_to_follow
    User.where.not(id: (followed_ids + [self])).order(created_at: :desc)
  end

  def shared_following(user)
    user.followeds.where(id: follower_ids).take
  end

  def followed?(user)
    followeds.exist?(user.id)
  end

  private

  def format_input
    self.full_name = full_name.downcase.titleize
    self.email = email.downcase
  end
end

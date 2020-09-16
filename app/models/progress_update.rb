class ProgressUpdate < ApplicationRecord
  validates :author, presence: true
  validates :text, presence: true, length: { maximum: 255,
                                             too_long: '255 characters in post is the maximum allowed.' }

  has_many :likes, inverse_of: :progress_update, dependent: :destroy

  belongs_to :author, class_name: 'User'

  scope :most_recent, -> { order(created_at: :desc) }
end

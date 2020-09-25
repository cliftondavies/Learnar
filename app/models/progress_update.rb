class ProgressUpdate < ApplicationRecord
  validates :author, presence: true
  validates :text, presence: true, length: { maximum: 255,
                                             too_long: '255 characters in post is the maximum allowed.' }

  belongs_to :author, class_name: 'User'

  scope :include_author, -> { includes(:author) }
  scope :most_recent, -> { order(created_at: :desc) }
end

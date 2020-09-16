class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :progress_update }
  validates :user, :progress_update, presence: true

  belongs_to :user
  belongs_to :progress_update
end

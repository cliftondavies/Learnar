class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :progress_update_id }
  validates :user, :progress_update, presence: true

  belongs_to :user
  belongs_to :progress_update
end

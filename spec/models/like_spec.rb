# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations' do
    let(:user) { User.create(email: 'test1@email.com', password: '123456', username: 'testuser', full_name: 'Test User') }
    let(:progress_update) { ProgressUpdate.create(author: user, text: 'Test progress update' ) }
    subject { Like.create(user: user, progress_update: progress_update) }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:progress_update_id) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:progress_update) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:progress_update) }
  end
end
# rubocop:enable Layout/LineLength

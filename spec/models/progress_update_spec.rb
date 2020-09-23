# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe ProgressUpdate, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:text) }

    it { is_expected.to validate_length_of(:text).is_at_most(255).with_long_message('255 characters in post is the maximum allowed.') }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:likes).inverse_of(:progress_update).dependent(:destroy) }

    it { is_expected.to belong_to(:author).class_name('User') }
  end
end
# rubocop:enable Layout/LineLength

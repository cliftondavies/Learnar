# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { User.create(email: 'test1@email.com', password: '123456', username: 'testuser', full_name: 'Test User') }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:full_name) }

    it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(16) }
    it { is_expected.to validate_length_of(:username).is_at_least(4).is_at_most(15) }

    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity }

    it { is_expected.to allow_value('test1@email.com').for(:email) }
    it { is_expected.not_to allow_value('test1email.com').for(:email) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:progress_updates).with_foreign_key(:author_id).inverse_of(:author).dependent(:destroy) }

    it { is_expected.to have_many(:followers).through(:incomings) }
    it { is_expected.to have_many(:followeds).through(:outgoings) }

    it { is_expected.to have_many(:incomings).class_name('Following').with_foreign_key(:followed_id).inverse_of(:followed).dependent(:destroy) }
    it { is_expected.to have_many(:outgoings).class_name('Following').with_foreign_key(:follower_id).inverse_of(:follower).dependent(:destroy) }
  end
end
# rubocop:enable Layout/LineLength

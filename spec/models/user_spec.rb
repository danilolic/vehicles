require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'with validations' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:role) }

    it do
      expect(subject).to define_enum_for(:role)
        .with_values(%i[client admin])
    end
  end
end

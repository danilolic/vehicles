require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  before do
    create(:vehicle)
  end

  describe 'with relationships' do
    it { is_expected.to belong_to(:model) }
    it { is_expected.to belong_to(:brand) }
  end

  describe 'with validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:fuel) }
    it { is_expected.to validate_presence_of(:year_model) }
  end
end

require 'rails_helper'

RSpec.describe Model, type: :model do
  before do
    create(:model)
  end

  describe 'with relationships' do
    it { is_expected.to have_many(:vehicles).dependent(:destroy) }
    it { is_expected.to belong_to(:brand) }
  end

  describe 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end

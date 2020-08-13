require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  subject { create(:vehicle) }

  describe 'with relationships' do
    it 'belongs_to brand' do
      expect(subject.brand).to be_a(Brand)
    end

    it 'belongs_to model' do
      expect(subject.model).to be_a(Model)
    end
  end

  describe 'with validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:fuel) }
    it { is_expected.to validate_presence_of(:year_model) }
  end
end

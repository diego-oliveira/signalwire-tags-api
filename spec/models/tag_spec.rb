require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    it { should have_many(:taggings).dependent(:destroy) }
    it { should have_many(:tickets).through(:taggings) }
  end

  describe 'scopes' do
    describe '.most_used' do
      it 'returns the tag with the highest taggings_count' do
        tag1 = FactoryBot.create(:tag, taggings_count: 5)
        tag2 = FactoryBot.create(:tag, taggings_count: 10)
        tag3 = FactoryBot.create(:tag, taggings_count: 3)

        expect(Tag.most_used).to eq(tag2)
      end

      it 'returns nil if there are no tags' do
        expect(Tag.most_used).to be_empty
      end
    end
  end

  describe 'taggings_count' do
    it 'increments when a tagging is created' do
      tag = FactoryBot.create(:tag)
      expect {
        FactoryBot.create(:tagging, tag: tag)
      }.to change { tag.reload.taggings_count }.by(1)
    end

    it 'decrements when a tagging is destroyed' do
      tag = FactoryBot.create(:tag)
      tagging = FactoryBot.create(:tagging, tag: tag)
      expect {
        tagging.destroy
      }.to change { tag.reload.taggings_count }.by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::Ticket::Contracts::Create do
  subject(:contract) { described_class.new(Ticket.new) }

  describe 'validations' do
    context 'when all required fields are present' do
      let(:params) { { title: 'Valid Title', user_id: 1 } }

      it 'is valid' do
        expect(contract.validate(params)).to be true
      end
    end

    context 'when title is missing' do
      let(:params) { { user_id: 1 } }

      it 'is invalid' do
        expect(contract.validate(params)).to be false
        expect(contract.errors[:title]).to include('must be filled')
      end
    end

    context 'when user_id is missing' do
      let(:params) { { title: 'Valid Title' } }

      it 'is invalid' do
        expect(contract.validate(params)).to be false
        expect(contract.errors[:user_id]).to include('must be filled')
      end
    end
  end

  describe 'tags' do
    context 'when tags are provided' do
      let(:params) { { title: 'Valid Title', user_id: 1, tags: ['tag1', 'tag2', 'TAG3'] } }

      it 'populates tags' do
        contract.validate(params)
        expect(contract.tags.map(&:name)).to eq(['tag1', 'tag2', 'tag3'])
      end

      it 'finds existing tags' do
        existing_tag = Tag.create(name: 'tag1')
        contract.validate(params)
        expect(contract.tags).to include(existing_tag)
      end

      it 'initializes new tags' do
        contract.validate(params)
        expect(contract.tags.any? { |tag| tag.new_record? && tag.name == 'tag2' }).to be true
      end
    end

    context 'when more than 5 tags are provided' do
      let(:params) { { title: 'Valid Title', user_id: 1, tags: ['tag1', 'tag2', 'tag3', 'tag4', 'tag5', 'tag6'] } }

      it 'is invalid' do
        expect(contract.validate(params)).to be false
        expect(contract.errors.full_messages).to include(' Max of five tags exceeded')
      end
    end
  end

  describe 'properties' do
    it 'has a title property' do
      expect(contract.class.definitions.keys).to include("title")
    end

    it 'has a user_id property' do
      expect(contract.class.definitions.keys).to include("user_id")
    end

    it 'has a tags property' do
      expect(contract.class.definitions.keys).to include("tags")
    end
  end
end

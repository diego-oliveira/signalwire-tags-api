require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
  end
end

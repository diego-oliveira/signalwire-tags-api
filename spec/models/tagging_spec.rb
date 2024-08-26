require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe 'associations' do
    it { should belong_to(:ticket) }
    it { should belong_to(:tag).counter_cache(true) }
  end
end

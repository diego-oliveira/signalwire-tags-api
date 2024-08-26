require 'rails_helper'

RSpec.describe Api::V1::Ticket::Operations::Create do
  let(:params) { { title: 'Test Ticket', user_id: 1234 } }

  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    context 'with valid params' do
      it 'creates a new ticket' do
        expect { result }.to change(Ticket, :count).by(1)
      end

      it 'returns success' do
        expect(result).to be_success
      end

      it 'returns the created ticket' do
        expect(result[:model]).to be_a(Ticket)
        expect(result[:model]).to be_persisted
      end

      it 'sets the ticket attributes' do
        ticket = result[:model]
        expect(ticket.title).to eq('Test Ticket')
        expect(ticket.user_id).to eq(1234)
      end

      it 'enqueues a SendWebhookJob' do
        expect(SendWebhookJob).to receive(:perform_later).with(
          "https://webhook.site/db2f601e-8b20-49d5-9a4e-fc3406c4385e",
          anything
        )
        result
      end
    end

    context 'with invalid params' do
      let(:params) { { title: '' } }

      it 'does not create a new ticket' do
        expect { result }.not_to change(Ticket, :count)
      end

      it 'returns failure' do
        expect(result).to be_failure
      end

      it 'returns contract errors' do
        expect(result['contract.default'].errors).to be_present
      end
    end
  end
end

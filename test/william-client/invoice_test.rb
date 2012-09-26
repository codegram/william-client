require_relative '../test_helper'

describe William::Invoice do
  let(:subscription) do
    collection = William::SubscriptionsCollection.new(William::Client.build)
    collection.find('5024e70c2b04a02926000006')
  end

  let(:invoices_collection) do
    invoices = subscription.send(:resource).links.invoices.embedded.invoices
    invoices_collection = William::InvoicesCollection.new(invoices)
  end

  let(:invoice) do
    invoices_collection[1]
  end

  let(:not_sent_invoice) do
    invoices_collection.first
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
    stub_request_factory('test/fixtures/subscription_show.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?id=5024e70c2b04a02926000006')
    stub_request_factory('test/fixtures/invoices.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/invoices')
  end

  describe 'attributes' do
    describe 'william_id' do
      it 'returns invoice id in william system' do
        invoice.william_id.should eq(2)
      end
    end

    describe 'sent_at' do
      it 'returns the date when the invoice was sent' do
        invoice.sent_at.should eq(Date.new(2012, 9, 24))
      end
    end

    describe 'ref' do
      it 'returns invoice reference' do
        invoice.ref.should eq('ref_002')
      end
    end

    describe 'amount' do
      it 'returns invoice total value' do
        invoice.total.should eq(280.00)
      end
    end
  end

  describe 'sent?' do
    it 'returns true when the invoice has already been sent' do
      invoice.sent?.should eq(true)
    end

    it 'returns false when the invoice has not been sent yet' do
      not_sent_invoice.sent?.should eq(false)
    end
  end
end

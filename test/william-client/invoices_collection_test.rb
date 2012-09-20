require_relative '../test_helper'

describe William::InvoicesCollection do
  let(:subscription) do
    collection = William::SubscriptionsCollection.new(William::Client.new)
    collection.find('5024e70c2b04a02926000006')
  end

  let(:invoices) do
    invoices = subscription.send(:resource).links.invoices.reload.embedded.invoices
    William::InvoicesCollection.new(invoices)
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
    stub_request_factory('test/fixtures/subscription_show.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?id=5024e70c2b04a02926000006')
    stub_request_factory('test/fixtures/invoices.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/invoices')
  end

  describe 'invoices' do
    it 'returns an array of Invoice belonging to Subscription' do
      invoices.first.class.should eq(William::Invoice)
      invoices.count.should eq(2)
    end
  end

  describe 'sent' do
    it 'returns an array of Invoice that belongs to a Subscription and that has been already sent to the customer.' do
      invoices.sent.first.william_id.should eq(2)
      invoices.sent.count.should eq(1)
    end
  end

  describe 'not_sent' do
    it 'returns an array of Invoice that belongs to a Subscription and that has not been sent yet to the customer.' do
      invoices.not_sent.first.william_id.should eq(1)
      invoices.not_sent.count.should eq(1)
    end
  end
end

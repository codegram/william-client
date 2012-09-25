require_relative '../test_helper'

describe William::Subscription do
  let(:subscription) do
    collection = William::SubscriptionsCollection.new(William::Client.new)
    collection.find('5024e70c2b04a02926000006')
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
  end

  describe 'attributes' do
    describe 'next_billing_date' do
      it 'returns next billing date for the subscription' do
        subscription.next_billing_date.should eq(Date.new(2013, 9, 04))
      end
    end

    describe 'periodicity' do
      it 'returns subscription charge periodicity' do
        subscription.periodicity.should eq(:monthly)
      end
    end
  end

  describe 'line_items' do
    it 'returns subscription line items' do
      subscription.line_items.first.name.should eq("Quota de centre")
      subscription.line_items.last.name.should eq("Quota d'alumnes")
    end
  end

  describe 'customer' do
    it 'returns subscription customer data' do
      subscription.customer.cif.should eq('12312345B')
      subscription.customer.name.should eq('Codegram')
      subscription.customer.email.should eq('blah@bleh.com')
    end
  end

  describe 'coupons' do
    before do
      stub_request_factory('test/fixtures/coupons.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/coupons')
    end

    it 'returns a CouponsCollection' do
      subscription.coupons.class.should eq(William::CouponsCollection)
    end
  end

  describe 'invoices' do
    before do
      stub_request_factory('test/fixtures/invoices.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/invoices')
    end

    it 'returns a InvoicesCollection' do
      subscription.invoices.class.should eq(William::InvoicesCollection)
    end
  end
end

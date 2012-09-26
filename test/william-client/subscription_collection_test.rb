require_relative '../test_helper'

describe William::SubscriptionsCollection do
  let(:client) do
    William::Client.build
  end

  let(:subscriptions) do
    William::SubscriptionsCollection.new(client)
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
  end

  describe 'subscriptions' do
    it 'shows all subscriptions of current app' do
      subscriptions.first.william_id.should eq("5024eac92b04a02d08000001")
      subscriptions.last.william_id.should eq("5024e70c2b04a02926000006")
      subscriptions.count.should eq(2)
    end
  end

  describe 'create' do
    before do
      stub_request_factory('test/fixtures/subscription_create.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions', :post)
      stub_request_factory('test/fixtures/subscription_create.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?subscription_id=5024e70c2b04a02926000009')
      subscription_data = stub
      @subscription = subscriptions.create(subscription_data)
    end

    it 'creates a new subscription for current app' do
      @subscription.william_id.should eq("5024e70c2b04a02926000009")
      subscriptions.count.should eq(3)
    end

    it 'returns a Subscription object' do
      @subscription.class.should eq(William::Subscription)
    end
  end

  describe 'find' do
    before do
      @subscription_id = '5024e70c2b04a02926000006'
      @subscription = subscriptions.find(@subscription_id)
    end

    it 'creates a new subscription for current app' do
      @subscription.william_id.should eq(@subscription_id)
    end

    it 'returns a Subscription object' do
      @subscription.class.should eq(William::Subscription)
    end
  end
end

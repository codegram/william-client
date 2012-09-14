require_relative '../test_helper'

describe William::SubscriptionsCollection do
  let(:client) do
    William::Client.new
  end

  let(:subscriptions) do
    William::SubscriptionsCollection.new(client)
  end

  def stub_request_factory(file, url, method = :get)
    response = File.read(file)
    stub_request(method, url).
      with(headers: {'Content-Type'=>'application/json'}).
      to_return(status: 200, body: response, headers: {content_type: 'application/json'})
    response
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
  end

  describe 'list_subscriptions' do
    it 'shows all subscriptions of current app' do
      subscriptions.first.william_id.should == "5024eac92b04a02d08000001"
      subscriptions.last.william_id.should == "5024e70c2b04a02926000006"
      subscriptions.count.should == 2
    end
  end

  describe 'create_subscription' do
    before do
      stub_request_factory('test/fixtures/subscription_6.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions', :post)
      stub_request_factory('test/fixtures/subscription_6.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?id=5024e70c2b04a02926000006')
      subscription_data = stub
      @subscription = subscriptions.create(subscription_data)
    end

    it 'creates a new subscription for current app' do
      @subscription.william_id.should == "5024e70c2b04a02926000006"
    end

    it 'returns an Subscription object' do
      @subscription.class.should eq(William::Subscription)
    end
  end
end

describe William::Subscription do
  let(:subscription) do
    response = File.read('test/fixtures/subscription_6.json')
    William::Subscription.new()
  end

  describe ''
end

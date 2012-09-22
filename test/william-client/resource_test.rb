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
    describe 'william_id' do
      it 'returns subscription id in william system' do
        subscription.william_id.should eq('5024e70c2b04a02926000006')
      end
    end
  end
end

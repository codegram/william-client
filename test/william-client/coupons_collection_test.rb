require_relative '../test_helper'

describe William::CouponsCollection do
  let(:subscription) do
    collection = William::SubscriptionsCollection.new(William::Client.build)
    collection.find('5024e70c2b04a02926000006')
  end

  let(:coupons) do
    coupons = subscription.send(:resource).links.coupons.embedded.coupons
    William::CouponsCollection.new(subscription, coupons)
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
    stub_request_factory('test/fixtures/subscription_show.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?id=5024e70c2b04a02926000006')
    stub_request_factory('test/fixtures/coupons.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/coupons')
  end

  describe 'coupons' do
    it 'returns an array of Coupon belonging to Subscription' do
      coupons.first.class.should eq(William::Coupon)
      coupons.count.should eq(4)
    end
  end

  describe 'applied' do
    it 'returns an array of Coupon belonging to Subscription that are already applied at some invoice' do
      coupons.applied.first.william_id.should eq('50334aca2b04a0139e000001')
      coupons.applied.count.should eq(2)
    end
  end

  describe 'current' do
    it 'returns an array of Coupon belonging to Subscription that are going to be applied to next invoice' do
      coupons.current.first.william_id.should eq('50320a582b04a01a1600000b')
      coupons.current.count.should eq(2)
    end
  end

  describe 'create' do
    # TODO Refactor after HyperClient returns Resources instead of HTTParty
    before do
      stub_request_factory('test/fixtures/coupon_1.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/coupons', :post)
    end

    it 'creates a new coupon for a subscription' do
      coupon_data = stub
      coupon = coupons.create(coupon_data)
    end
  end
end

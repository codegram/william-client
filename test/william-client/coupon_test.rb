require_relative '../test_helper'

describe William::Coupon do
  let(:subscription) do
    collection = William::SubscriptionsCollection.new(William::Client.build)
    collection.find('5024e70c2b04a02926000006')
  end

  let(:coupon) do
    coupons = subscription.send(:resource).links.coupons.embedded.coupons
    coupons_collection = William::CouponsCollection.new(subscription, coupons)
    coupons_collection[1]
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
    stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')
    stub_request_factory('test/fixtures/subscription_show.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?id=5024e70c2b04a02926000006')
    stub_request_factory('test/fixtures/coupons.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/coupons')
  end

  describe 'attributes' do
    describe 'william_id' do
      it 'returns coupon id in william system' do
        coupon.william_id.should eq('50334aca2b04a0139e000001')
      end
    end

    describe 'used_at' do
      it 'returns the date when the coupon was applied' do
        coupon.used_at.should eq(Date.new(2012, 9, 24))
      end
    end

    describe 'description' do
      it 'returns coupon description' do
        coupon.description.should eq('By the face 2')
      end
    end

    describe 'amount' do
      it 'returns coupon amount' do
        coupon.amount.should eq(250.23)
      end
    end
  end
end

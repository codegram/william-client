require_relative '../test_helper'

describe William::Client do
  let(:client) do
    William::Client.new
  end

  def stub_request_factory(file, url)
    response = File.read(file)
    stub_request(:get, url).
      with(headers: {'Content-Type'=>'application/json'}).
      to_return(status: 200, body: response, headers: {content_type: 'application/json'})
    response
  end

  before do
    stub_request_factory('test/fixtures/entry_point.json','http://localhost:3000')
  end

  describe 'list_subscriptions' do
    it 'shows all subscriptions of current app' do
      stub_request_factory('test/fixtures/subscriptions.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions')

      client.list_subscriptions.to_s.should match 'self\"=>{\"href\"=>\"/apps/5024e70c2b04a02926000001/subscriptions/5024eac92b04a02d08000001\"}'
      client.list_subscriptions.to_s.should match 'self\"=>{\"href\"=>\"/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006\"}'
    end
  end

  describe 'create_subscription' do
    it 'creates a new subscription for current app' do
      subscription = stub
      client.should_receive(:create_subscription).with(subscription)
      client.create_subscription(subscription)
    end
  end

  describe 'get data from a given subscription' do
    before do
      stub_request_factory('test/fixtures/subscription_6.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions?id=5024e70c2b04a02926000006')
    end

    describe 'get_subscription_resource' do
      it 'returns a Hyperclient::Resource object with the given subscription id' do
        resource = client.get_subscription_resource("5024e70c2b04a02926000006")
        resource.class.should equal Hyperclient::Resource
        resource.attributes['id'].should == "5024e70c2b04a02926000006"
      end
    end

    describe 'create_coupon_for' do
      it 'creates a new coupon for a given subscription' do
        coupon = stub
        client.should_receive(:create_coupon).with(coupon)
        client.create_coupon(coupon)
      end
    end

    describe 'show_last_invoice_for' do
      it 'shows last invoice of a given subscription' do
        stub_request_factory('test/fixtures/invoices.json','http://localhost:3000/apps/5024e70c2b04a02926000001/subscriptions/5024e70c2b04a02926000006/invoices')

        invoice = client.last_invoice_of("5024e70c2b04a02926000006")
        invoice.attributes['ref'].should == 'ref_002'
      end
    end
  end
end

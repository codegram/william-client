require_relative '../test_helper'

require 'william-client'

describe William::Client do
  let(:client) do
    William::Client.new
  end

  describe 'list_subscriptions' do
    it 'shows all subscriptions of current app' do
      client.should_receive(:create_subscription).with({caca: futi})
    end
  end

  describe 'create_subscription' do
    it 'creates a new subscription for current app' do
    end
  end
end

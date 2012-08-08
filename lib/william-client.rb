require "william-client/version"
require 'hyperclient'

module William
  class Client
    include Hyperclient

    entry_point 'http://localhost:3000'
    http_options(headers: {"Content-Type" => "application/json"}, debug: true)
    auth :digest, 'Test', '547e16a6a6a9a9dabe5ce49ac3f1cf03'

    def list_subscriptions
    end

    def create_subscription
    end

    def show_subscription
    end

    def create_coupon
    end

    def show_invoice
    end

    # def create_subscription
    #   Client.any_instance.should_receive(:create_subscription).with({caca: futi})
    #   c = William::Client.new
    #   c.links.subscriptions.reload.embedded.subscriptions
    #   c.links.subscriptions.post({subscription: abat_oliva}.to_json)
    #   abat_oliva = {periodicity: 'annually', items: {'centre' => 300,
    #   "alumnes" => (30*9)}, customer: {name: 'Escola ABAT Oliva', cif:
    #   'B6523423', email: 'divins@codegram.com', address: ['Cacafuti 1']}}
    #   c.links.subscriptions.reload.embedded.subscriptions.length
    #   c.links.subscriptions.reload.embedded.subscriptions.first.attributes['items']
    # end
  end
end

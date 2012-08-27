require "william-client/version"
require "william-client/config"
require 'hyperclient'

module William
  class Client
    include Hyperclient

    # Public: Initializes the client with the necessary connection to the
    # service.
    #
    # Returns nothing.
    def initialize
      self.class.entry_point{ William.config.william_api_url }
      self.class.http_options(headers: {"Content-Type" => "application/json"}, debug: true)
      self.class.auth{ {type: :digest, user: William.config.app_name, password: William.config.app_token} }
    end

    # Public: lists all subscriptions of the application.
    #
    # Returns an Array of Hyperclient::Resource
    def list_subscriptions
      links.subscriptions.reload.embedded.subscriptions
    end

    # Public: Creates a new subscription for the application given the
    # subscription data.
    #
    # subscription - A Hash with subscription data.
    #   Example:
    #   {
    #     periodicity:'annually',
    #     items:{'centre' => 300, "alumnes" => (30*9)},
    #     customer:{
    #       name:'Escola Codegram',
    #       cif:'b6523423',
    #       email: 'info@codegram.com',
    #       address: ['Fake street, 123', 'Terrassa']
    #     }
    #   }
    #
    # Returns the parsed HTTP response with new subscription data.
    def create_subscription(subscription)
      links.subscriptions.post({subscription: subscription}.to_json)
    end

    # Public: Creates a new coupon for the given subscription,
    #
    # subscription_id - The subscription that has this coupon.
    #
    # coupon - A Hash with coupon data.
    #   Example:
    #   {
    #     "description":"Descompte per referencia",
    #     "amount":23.45
    #   }
    #
    # Returns the parsed HTTP response with new coupon data.
    def create_coupon_for(subscription_id, coupon)
      subscription = get_subscription_resource(subscription_id)
      subscription.links.coupons.post({coupon: coupon}.to_json)
    end

    # Public: gets last generated invoice for a given subscription.
    #
    # subscription_id - The id of the subscription from which retrieve
    # invoices.
    #
    # Returns an Hyperclient::Resource
    def last_invoice_of(subscription_id)
      subscription = get_subscription_resource(subscription_id)
      subscription.links.invoices.embedded.invoices.last
    end


    # Public: gets a subscription given its ID.
    #
    # subscription_id - The id of the subscription that we want.
    #
    # Returns an Hyperclient::Resource
    def get_subscription_resource(subscription_id)
      # TODO: Finish Hyperclient gem uri_template branch so we can use the
      # subscriptions link 'find' to retrieve a single subscription.
      # The link is already present at subscription's view of the William API.
      Hyperclient::Resource.new(links['subscriptions'].url.concat("?id=#{subscription_id}"))
    end

    # def create_subscription
    #   Client.any_instance.should_receive(:create_subscription).with({caca: futi})
    #   c = William::Client.new
    #   c.links.subscriptions.reload.embedded.subscriptions
    #   c.links.subscriptions.post({subscription: abat_oliva}.to_json)
    #   abat_oliva = {periodicity: 'annually', items: {'centre' => 300,
    #   "alumnes" => (30*9)}, customer: {name: 'escola abat oliva', cif:
    #   'b6523423', email: 'divins@codegram.com', address: ['cacafuti 1']}}
    #   c.links.subscriptions.reload.embedded.subscriptions.length
    #   c.links.subscriptions.reload.embedded.subscriptions.first.attributes['items']
    # end
  end
end

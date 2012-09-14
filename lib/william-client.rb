require "william-client/version"
require "william-client/config"
require 'hyperclient'

module William
  class SubscriptionsCollection
    include Enumerable

    # Public: Initializes the Subscripti with the necessary connection to the
    # service.
    #
    # Returns nothing.
    def initialize(client)
      @client = client
      @subscriptions = response.reload.embedded.subscriptions.map{|subscription| Subscription.new(subscription)}
    end

    def response
      @client.links.subscriptions
    end

    def each(&block)
      @subscriptions.each(&block)
    end

    def last
      @subscriptions.last
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
    # Returns a Subscription,
    def create(subscription)
      create_response = response.post({subscription: subscription}.to_json)
      # TODO WTF MAN! FOLLOWING LINE MUST DIE. Hyperclient should return an
      # Hyperclient::Resource instead of HTTPartyResponse
      if create_response.success?
        find(create_response['id'])
      else
      end
    end

    # Public: gets a subscription given its ID.
    #
    # subscription_id - The id of the subscription that we want.
    #
    # Returns an Hyperclient::Resource
    def find(subscription_id)
      # TODO: Finish Hyperclient gem uri_template branch so we can use the
      # subscriptions link 'find' to retrieve a single subscription.
      # The link is already present at subscription's view of the William API.
      resource = Hyperclient::Resource.new(@client.links['subscriptions'].url.concat("?id=#{subscription_id}"))
      Subscription.new(resource)
    end
  end

  class Subscription
    def initialize(resource)
      @resource = resource
    end

    def resource
      @resource
    end

    def attributes
    end

    def william_id
      @resource.attributes['id']
    end

    def customer
    end

    def line_items
    end

    def coupons
      coupons = @resource.links.coupons.reload.embedded.coupons
      CouponsCollection.new(coupons)
    end

    def invoices
    end
  end

  class CouponsCollection
    include Enumerable

    def initalize(coupons)
      @coupons = coupons.map{|coupon| Coupon.new(coupon) }
    end

    def current
      @coupons.select{|coupon| coupon.date.empty?}
    end

    def applied
      @coupons.reject{|coupon| coupon.date.empty?}
    end

    def each(&block)
      @coupons.each do |coupon|
        block.call(coupon)
      end
    end
  end

  class Coupon
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
    def create(subscription, coupon)
      subscription.resource.links.coupons.post({coupon: coupon}.to_json)
    end
  end

  class Invoices
  end

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
  end

  # class ClientOld
  #   include Hyperclient

  #   # Public: Initializes the client with the necessary connection to the
  #   # service.
  #   #
  #   # Returns nothing.
  #   def initialize
  #     self.class.entry_point{ William.config.william_api_url }
  #     self.class.http_options(headers: {"Content-Type" => "application/json"}, debug: true)
  #     self.class.auth{ {type: :digest, user: William.config.app_name, password: William.config.app_token} }
  #   end

  #   # Public: lists all subscriptions of the application.
  #   #
  #   # Returns an Array of Hyperclient::Resource
  #   def list_subscriptions
  #     links.subscriptions.reload.embedded.subscriptions
  #   end

  #   # Public: Creates a new subscription for the application given the
  #   # subscription data.
  #   #
  #   # subscription - A Hash with subscription data.
  #   #   Example:
  #   #   {
  #   #     periodicity:'annually',
  #   #     items:{'centre' => 300, "alumnes" => (30*9)},
  #   #     customer:{
  #   #       name:'Escola Codegram',
  #   #       cif:'b6523423',
  #   #       email: 'info@codegram.com',
  #   #       address: ['Fake street, 123', 'Terrassa']
  #   #     }
  #   #   }
  #   #
  #   # Returns the parsed HTTP response with new subscription data.
  #   def create_subscription(subscription)
  #     links.subscriptions.post({subscription: subscription}.to_json)
  #   end

  #   # Public: Creates a new coupon for the given subscription,
  #   #
  #   # subscription_id - The subscription that has this coupon.
  #   #
  #   # coupon - A Hash with coupon data.
  #   #   Example:
  #   #   {
  #   #     "description":"Descompte per referencia",
  #   #     "amount":23.45
  #   #   }
  #   #
  #   # Returns the parsed HTTP response with new coupon data.
  #   def create_coupon_for(subscription_id, coupon)
  #     subscription = get_subscription_resource(subscription_id)
  #     subscription.links.coupons.post({coupon: coupon}.to_json)
  #   end

  #   # Public: gets last generated invoice for a given subscription.
  #   #
  #   # subscription_id - The id of the subscription from which retrieve
  #   # invoices.
  #   #
  #   # Returns an Hyperclient::Resource
  #   def last_invoice_of(subscription_id)
  #     subscription = get_subscription_resource(subscription_id)
  #     subscription.links.invoices.embedded.invoices.last
  #   end

  #   # Public: gets a subscription given its ID.
  #   #
  #   # subscription_id - The id of the subscription that we want.
  #   #
  #   # Returns an Hyperclient::Resource
  #   def get_subscription_resource(subscription_id)
  #     # TODO: Finish Hyperclient gem uri_template branch so we can use the
  #     # subscriptions link 'find' to retrieve a single subscription.
  #     # The link is already present at subscription's view of the William API.
  #     Hyperclient::Resource.new(links['subscriptions'].url.concat("?id=#{subscription_id}"))
  #   end

  #   # def create_subscription
  #   #   Client.any_instance.should_receive(:create_subscription).with({caca: futi})
  #   #   c = William::Client.new
  #   #   c.links.subscriptions.reload.embedded.subscriptions
  #   #   c.links.subscriptions.post({subscription: abat_oliva}.to_json)
  #   #   abat_oliva = {periodicity: 'annually', items: {'centre' => 300,
  #   #   "alumnes" => (30*9)}, customer: {name: 'escola abat oliva', cif:
  #   #   'b6523423', email: 'divins@codegram.com', address: ['cacafuti 1']}}
  #   #   c.links.subscriptions.reload.embedded.subscriptions.length
  #   #   c.links.subscriptions.reload.embedded.subscriptions.first.attributes['items']
  #   # end
  # end
end

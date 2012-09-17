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

    def [](index)
      @subscriptions[index]
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
end

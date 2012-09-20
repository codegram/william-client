module William
  # Class: This class is used to manage all william subscriptions for current
  # App.
  #
  # Returns an array of Subscription.
  class SubscriptionsCollection
    include Enumerable

    # Public: Initializes the SubscriptionsCollection with the necessary 
    # connection to the service and an array of current subscriptions of the 
    # app.
    #
    # client - an hypermedia client ready to request information to William.
    #
    # Returns nothing.
    def initialize(client)
      @client = client
      @subscriptions = response.reload.embedded.subscriptions.map{|subscription| Subscription.new(subscription)}
    end

    # Public: Fetch again all subscription from William.
    #
    # Returns nothing.
    def reload
      @subscriptions = response.reload.embedded.subscriptions.map{|subscription| Subscription.new(subscription)}
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
      # TODO: This has to be refactored whenever hyperclient returns an
      # Hyperclient::Resource instead of HTTParty response.
      if create_response.success?
        new_subscription = Subscription.new(Hyperclient::Resource.new(response.url.concat("?id=#{create_response['id']}")))
        @subscriptions << new_subscription
        find(create_response['id'])
      else
        nil
      end
    end

    # Public: gets a subscription given its ID.
    #
    # subscription_id - The id of the subscription that we want.
    #
    # Returns an Hyperclient::Resource.
    def find(subscription_id)
      @subscriptions.select{|subscription| subscription.william_id == subscription_id}.first
    end

    private
    # Internal: Shortcut to subscriptions link of client initial response.
    #
    # Returns subscriptions link.
    def response
      @client.links.subscriptions
    end
  end
end

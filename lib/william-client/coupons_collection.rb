module William
  # Class: This class is used to manage all coupons for a Subscription.
  #
  # Returns an array of Coupon.
  class CouponsCollection < Collection
    include Enumerable
    attr_reader :subscription

    # Public: Initializes the CouponsCollections.
    #
    # subscription - the subscription which this coupons belongs to.
    # coupons - array of coupons.
    #
    # Returns nothing.
    def initialize(subscription, coupons)
      @subscription = subscription
      @collection = coupons.map{|coupon| Coupon.new(coupon) }
    end

    # Public: Lists all coupons that have not been applied to an invoice yet.
    #
    # Returns an Array of Coupon.
    def current
      @collection.reject(&:applied?)
    end

    # Public: Lists all coupons that has already been applied to an invoice.
    #
    # Returns an Array of Coupon.
    def applied
      @collection.select(&:applied?)
    end

    # Public: Creates a new coupon for a given subscription.
    # subscription data.
    # TODO: This has to be refactored whenever hyperclient returns an
    # Hyperclient::Resource instead of HTTParty response.
    #
    # subscription - the subscription which this coupon belongs to.
    # coupons - coupon data.
    #   Example:
    #   {
    #     "description":"Descompte per referencia",
    #     "amount":23.45
    #   }
    #
    # Returns a William response.
    def create(coupon)
      create_response = @subscription.links.coupons.post({coupon: coupon}.to_json)
      Logger.warning("Coupon: #{coupon} not created for subscription with id: #{subscription.attributes['id']}") unless create_response.success?
      create_response
    end
  end
end

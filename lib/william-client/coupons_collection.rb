module William
  class CouponsCollection
    include Enumerable

    def initialize(subscription, coupons)
      @subscription = subscription
      @coupons = coupons.map{|coupon| Coupon.new(coupon) }
    end

    def current
      @coupons.reject{|coupon| coupon.used_at}
    end

    def applied
      @coupons.select{|coupon| coupon.used_at}
    end

    def each(&block)
      @coupons.each(&block)
    end

    def [](index)
      @coupons[index]
    end

    def create(subscription, coupon)
      create_response = subscription.send(:resource).links.coupons.post({coupon: coupon}.to_json)
      Logger.warning("Coupon: #{coupon} not created for subscription with id: #{subscription.attributes['id']}") unless create_response.success?
      create_response
    end
  end
end

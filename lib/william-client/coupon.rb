module William
  class Coupon
    def initialize(coupon)
      @resource = coupon
    end

    def william_id
      attributes['id']
    end

    def used_at
      return nil unless attributes['used_at']
      Date.parse(attributes['used_at'])
    end

    def description
      attributes['description']
    end

    def amount
      attributes['amount'].to_f
    end

    private
    def resource
      @resource
    end

    def attributes
      resource.attributes
    end
  end
end

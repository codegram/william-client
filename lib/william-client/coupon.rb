module William
  # Class: This class represents a William Coupon.
  class Coupon
    # Public: Initializes the Coupon with the resource data it
    # represents.
    #
    # resource - Hyperclient::Resource with all coupon data.
    #
    # Returns nothing.
    def initialize(resource)
      @resource = resource
    end

    # Public: Coupon id at William service.
    #
    # Returns a String.
    def william_id
      attributes['id']
    end

    # Public: Date in which the coupon has been applied to an invoice.
    #
    # Returns a Date.
    def used_at
      return nil unless attributes['used_at']
      Date.parse(attributes['used_at'])
    end

    # Public: This is easy...
    #
    # Returns a String.
    def description
      attributes['description']
    end

    # Public: The total discount.
    #
    # Returns a Float.
    def amount
      attributes['amount'].to_f
    end

    # Public: Returns true when the coupon has already been used in an invoice.
    # Returns false when it's still virign.
    #
    # Returns a Boolean.
    def applied?
      return false unless used_at
      true
    end

    private
    # Internal: Used to return original resource of this cooupon.
    #
    # Returns an Hyperclient::Resource.
    def resource
      @resource
    end

    # Internal: Shortcut for coupon attributes.
    #
    # Returns an Array of attributes.
    def attributes
      resource.attributes
    end
  end
end

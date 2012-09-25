module William
  # Class: This class represents a William Coupon.
  class Coupon < Resource
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

    # Public: The total amount that will be applied as a discount.
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
  end
end

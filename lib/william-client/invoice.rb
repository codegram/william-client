module William
  # Class: This class represents a William Invoice.
  class Invoice
    # Public: Initializes the Invoice with the resource data it
    # represents.
    #
    # resource - Hyperclient::Resource with all invoice data.
    #
    # Returns nothing.
    def initialize(resource)
      @resource = resource
    end

    # Public: Invoice id at William service.
    #
    # Returns a String.
    def william_id
      attributes['id']
    end

    # Public: Date in which the coupon has been sent to the customer.
    #
    # Returns a Date.
    def sent_at
      return nil unless sent?
      Date.parse(attributes['sent_at'])
    end

    # Public: Invoice reference, financial stuff.
    #
    # Returns a String.
    def ref
      attributes['ref']
    end

    # Public: The total invoice amount.
    #
    # Returns a Float.
    def total
      attributes['total'].to_f
    end

    # Public: Returns true if the invoice has already been sent to the customer
    # or false if it has not.
    #
    # Returns Boolean.
    def sent?
      return false unless attributes['sent_at'] != ''
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

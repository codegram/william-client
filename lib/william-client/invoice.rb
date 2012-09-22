module William
  # Class: This class represents a William Invoice.
  class Invoice < Resource
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
  end
end

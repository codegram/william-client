module William
  # Class: This class is used to manage all invoices of a Subscription.
  #
  # Returns an array of Invoice
  class InvoicesCollection
    include Enumerable

    # Public: Initializes the InvoicesCollections.
    #
    # invoices - array of coupons.
    #
    # Returns nothing.
    def initialize(invoices)
      @invoices = invoices.map{|invoice| Invoice.new(invoice) }
    end

    # Public: Lists all invoices that has not been sent to the customer yet.
    #
    # Returns an Array of Invoice.
    def not_sent
      @invoices.reject{|invoice| invoice.sent?}
    end

    # Public: Lists all invoices that has already been sent to the customer.
    #
    # Returns an Array of Invoice.
    def sent
      @invoices.select{|invoice| invoice.sent?}
    end

    def each(&block)
      @invoices.each(&block)
    end

    def [](index)
      @invoices[index]
    end
  end
end
